import consumer from "./consumer"

$(document).on('turbolinks:load', function () {

    const messages = $('#messages') // messagesのエレメント

    // ルームIDを#messages内のdata-room-idから取得し、
    // chats_channel.rbでも使えるようにする
    const room = consumer.subscriptions.create(
        {channel: "RoomChannel", room_id: messages.data('room_id')}, {

            connected() {
                // 未使用
            },

            disconnected() {
                // 未使用
            },

            received(data) {
                // 受け取ったデータを追加する
                //  dataには、chats_channel.rbから送られるパラメーター名に
                //  部分テンプレートに文字が埋め込まれているものが送られてくるので
                //  配列からmessageを抜き出し追加している。
                messages.append(data['message'])
            },

            speak: function (message) {
              return this.perform('speak', {message: message})
            }
        });

    // 入力フォームの制御
    $(document).ready(function () {
        // 入力エリアのエレメント
        const textElement = $('#message')
        // 入力エリアのEnterKey検出
        textElement.keypress(function (event) {
            if (event.shiftKey && event.keyCode === 13) {
                // speakを呼び出し
                room.speak(textElement.val())
                // 入力エリアを空にする
                textElement.val('')
                // submitイベントの取り消し
                //  改行が含まれてしまうための回避
                event.preventDefault()
            }
        })
    })
})

// $(function() {
//   console.log("test")
//   // const chatChannel = consumer.subscriptions.create({ channel: 'RoomChannel', room: $('#messages').data('room_id') }, {
//   const chatChannel = consumer.subscriptions.create("RoomChannel", {

//     connected() {
//       // Called when the subscription is ready for use on the server
//     },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//   },

//   // received(data) {
//   //   console.log("test3")
//   //   // Called when there's incoming data on the websocket for this channel
//   // },

//     received: function(data) {
//     console.log("test3")
//     console.log(data)
//     return alert(data['message']);
//   },
//   // received: function(data) {

//   //   return $('#messages').append(data['message']);
//   // },


//   speak: function(message) {
//     console.log("test2")
//     return this.perform('speak', {
//       message: message
//     });
//   },

// });
// console.log(chatChannel)

//   // $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
//   //   console.log("test4")
//   //   console.log(this)
//   //   if (event.keyCode === 13) {
//   //     chatChannel.speak(event.target.value);
//   //     event.target.value = '';
//   //   return event.preventDefault();
//   //   }
//   // });
//   // $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
//   //   console.log("test4")
//   //   console.log(this)
//   // if (event.keyCode === 13) {
//   //   chatChannel.speak(event.target.value);
//   //   event.target.value = '';
//   //   return event.preventDefault();
//   // }
//   // });
// });