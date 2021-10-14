var url = $("body").attr('url');

var constraints = { video: { facingMode: "environment" }, audio: false };
var cameraView = document.querySelector("#camera--view"),
    cameraSensor = document.querySelector("#camera--sensor")

var cameraStream;

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [year, month, day].join('-');
}

function cameraStart() {
    navigator.mediaDevices.getUserMedia(constraints).then(function(stream) {
        cameraStream = stream;
        track = cameraStream.getTracks()[0];
        cameraView.srcObject = cameraStream;
    })
    .catch(function(error) {
        console.error("Oops. Something is broken.", error);
    });
}

function takePicture() {
    cameraSensor.width = cameraView.videoWidth;
    cameraSensor.height = cameraView.videoHeight;
    cameraSensor.getContext("2d").drawImage(cameraView, 0, 0);
    $("[name=face]").val(cameraSensor.toDataURL("image/jpg"));
}

function cameraStop() {
    cameraStream.getTracks().forEach(function(track) {
        track.stop();
    })
}

if($(".datatable").length) {
    $(".datatable").DataTable();
}

if($('.search-property').length) {
    $(".place-result").hide();

    $(window).keydown(function(event){
        if(event.keyCode == 13) {
          event.preventDefault();
          return false;
        }
      });

    $('.search-property').on('keyup', function() {
        let q = $(this).val();
        let html = '';
        if(q != "") {
            $.ajax({
                type: 'get',
                url: 'https://mamikos.com/garuda/suggest?q=' + q,
                success: function(result) {
                    result.data.areas.forEach(function(data) {
                        html += `<div class="w-100 cursor-pointer p-3 place-item" title="${data.title}" latitude="${data.latitude}" longitude="${data.longitude}">
                                    <h6 class="font-weight-bold mb-1">${data.title}</h6>
                                    <p class="no-margin text-truncate">${data.area}</p>
                                 </div>`
                    }) 

                    $(".place-result").html(html);
                    $(".place-result").show();
                    $(".place-item").click(function() {
                        let title = $(this).attr('title');
                        let latitude = $(this).attr('latitude');
                        let longitude = $(this).attr('longitude');

                        $("[name=q]").val(title);
                        $("[name=latitude]").val(latitude);
                        $("[name=longitude]").val(longitude);

                        $(".place-result").hide();
                        $(".search-property").val(title);
                        $("#search-form").submit();
                    })
                }
            })
        } else {
            $(".place-result").hide();
        }
    })

    $(".filter-type-btn").click(function() {
        $(".filter-type-btn").removeClass('btn-primary text-white');
        $(".filter-type-btn").addClass('btn-outline-primary');
        $(this).removeClass('btn-outline-primary');
        $(this).addClass('btn-primary text-white');
        let place = $("[name=q]").val();
        let type = $(".filter-type-btn.text-white").attr('type');
        let filter = $(".filter-btn.text-white").attr('filter');

        $(".list-place").html(`<div class="alert alert-success">Mencari property....</div>`)

        $.ajax({
            type: 'get',
            url: `${url}/search/filter/${place}/${type}`,
            data: `filter=${filter}`,
            success: function(result) {
                if(result != '') {
                    $(".list-place").html(result)
                    $(window).on('scroll', function() {    
                        if ($(window).scrollTop() > oTop) {
                            $("#map").css({'position':'relative', 'top':'0', 'height':'100%', 'width':'100%', 'left':'0'})
                        } else {
                            $("#map").css({'position':'fixed', 'top':'90px', 'height':'100%', 'width':'calc(60% - 15px)', 'right':'5vw', 'left':'unset'})
                        }
                    });
                } else {
                    $(".list-place").html(`<div class="alert alert-danger">Tidak ada properti yang cocok</div>`)
                    $("#map").css({'position':'relative', 'top':'0', 'height':'100%', 'width':'100%', 'left':'0'})
                    $(window).on('scroll', function() { 
                        $("#map").css({'position':'relative', 'top':'0', 'height':'100%', 'width':'100%', 'left':'0'})
                    });
                }
            }
        })
    })

    $(".filter-btn").click(function() {
        $(".filter-btn").removeClass('btn-primary text-white');
        $(".filter-btn").addClass('btn-outline-primary');
        $(this).removeClass('btn-outline-primary');
        $(this).addClass('btn-primary text-white');

        let place = $("[name=q]").val();
        let type = $(".filter-type-btn.text-white").attr('type');
        let filter = $(".filter-btn.text-white").attr('filter');

        $(".list-place").html(`<div class="alert alert-success">Mencari property....</div>`)

        $.ajax({
            type: 'get',
            url: `${url}/search/filter/${place}/${type}`,
            data: `filter=${filter}`,
            success: function(result) {
                if(result != '') {
                    $(".list-place").html(result)
                    $(window).on('scroll', function() {    
                        if ($(window).scrollTop() > oTop) {
                            $("#map").css({'position':'relative', 'top':'0', 'height':'100%', 'width':'100%', 'left':'0'})
                        } else {
                            $("#map").css({'position':'fixed', 'top':'90px', 'height':'100%', 'width':'calc(60% - 15px)', 'right':'5vw', 'left':'unset'})
                        }
                    });
                } else {
                    $(".list-place").html(`<div class="alert alert-danger">Tidak ada properti yang cocok</div>`)
                    $("#map").css({'position':'relative', 'top':'0', 'height':'100%', 'width':'100%', 'left':'0'})
                    $(window).on('scroll', function() { 
                        $("#map").css({'position':'relative', 'top':'0', 'height':'100%', 'width':'100%', 'left':'0'})
                    });

                }
            }
        })

    })
}

if($('.place-img-slide').length) {
    $('.place-img-slide').owlCarousel({
        margin:0,
        nav:false,
        dots: false,
        loop:true,
        autoplay:true,
        autoplayTimeout:3000,
        autoplayHoverPause:true,
        responsive:{
            0:{
                items:1
            }
        }
    })
}

if($('.owl-carousel').length) {
    $('.owl-carousel').owlCarousel({
        margin:30,
        nav:false,
        dots: true,
        responsive:{
            768:{
                items:2
            }
        }
    })
}


$(window).on('scroll', function() {
    if(window.pageYOffset == 0) {
        $(".navbar-home").attr('class', 'navbar navbar-home d-flex text-white align-items-center');
        $(".navbar-home li a").css('color', 'white');
        $(".navbar-home li a:hover").css('color', 'var(--primary-color)!important');
    } else {
        $(".navbar-home").attr('class', 'navbar navbar-home bg-white d-flex align-items-center is-shadow');
        $(".navbar-home li a").css('color', 'black');
        $(".navbar-home li a:hover").css('color', 'var(--primary-color)!important');
    }
})

if($("#typed").length) {
    var typed = new Typed('#typed', {
        strings: ['APARTEMENT', 'RUMAH', 'KONTRAKAN'],
        typeSpeed: 100,
        backSpeed: 0,
        backDelay: 500,
        startDelay: 2000,
        fadeOut: true,
        loop: true
    });
}

if($("#map").length) {
    var oTop = $('footer').offset().top - window.innerHeight;
    let lat = $("#map").attr('lat');
    let long = $("#map").attr('long');

    if ($(window).scrollTop() > oTop) {
        $("#map").css({'position':'relative', 'top':'0', 'height':'100%', 'width':'100%', 'left':'0'})
    }

    $(window).on('scroll', function() {    
        if ($(window).scrollTop() > oTop) {
            $("#map").css({'position':'relative', 'top':'0', 'height':'100%', 'width':'100%', 'left':'0'})
        } else {
            $("#map").css({'position':'fixed', 'top':'90px', 'height':'100%', 'width':'calc(60% - 15px)', 'right':'5vw', 'left':'unset'})
        }
    });

    var mymap = L.map('map').setView([lat, long], 13);
    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoicWRyMzExMTIiLCJhIjoiY2s5czN1M3E4MTE5dTNmbzN0dzlvMW84cCJ9.xISAyVMSyc9_MWS3-nf5vQ', {
        maxZoom: 18,
        id: 'mapbox/streets-v11',
        tileSize: 512,
        zoomOffset: -1,
        accessToken: 'pk.eyJ1IjoicWRyMzExMTIiLCJhIjoiY2s5czN1M3E4MTE5dTNmbzN0dzlvMW84cCJ9.xISAyVMSyc9_MWS3-nf5vQ'
    }).addTo(mymap);
    var marker = L.marker([lat, long]).addTo(mymap);
}

if($("#camera").length) {
    $("#camera").css('visibility', 'visible');
    cameraStart();
    $("#submit-reg").on('click', function() {
        takePicture();
        setTimeout(function() {
            cameraStop();
            $("#submit-data").submit();
        }, 1000)
    })
}

if($(".chat-bubble").length) {
    function sendChat(userId, userName, ownerId, ownerName, userFace, message) {
        let sender = [];
        sender[0] = parseInt(userId);
        sender[1] = parseInt(ownerId);

        db.collection('chat').doc(`${ownerId}:${userId}`).set({
          ownerName: ownerName,
          message: message,
          userName: userName,
          ownerId: parseInt(ownerId),
          userId: parseInt(userId),
          sender: sender,
          face: userFace,
          date: + new Date()
        });

        db.collection('chat').doc(`${ownerId}:${userId}`).collection('messages').doc().set({
          message: message,
          sender: parseInt(userId),
          date: + new Date()
        })

        $("#chat-send").val('');
    }

    function getChat(userId, ownerId) {
        db.collection('chat').doc(`${ownerId}:${userId}`).collection('messages').orderBy('date', 'asc').onSnapshot((snapshot) => {
            let html = ''
            snapshot.docs.forEach(function(data) {
                let d = data.data();

                if(d.sender != userId) {
                  html += `<div class="chat-reply">
                              <div class="text">${d.message}</div>
                          </div>`
                } else {
                  html += `<div class="chat-send">
                              <div class="text">${d.message}</div>
                          </div>`
                }
            })

            $(".chat-content-list").html(html);
            var scroll = $('.chat-content-list').prop('scrollHeight'); 
            $('.chat-content-list').slimScroll({scrollTo : scroll + 'px', height: '340px'});
        })
    }

    let userId = $(".chat-box").attr('userId');
    let userName = $(".chat-box").attr('userName');
    let userFace = $(".chat-box").attr('userFace');

    let boxWidth = $(".chat-box").width() + 50;

    db.collection('chat').where('sender', 'array-contains', parseInt(userId)).onSnapshot((snapshot) => {
        let html = ''
        if(snapshot.docs.length > 0) {
            snapshot.docs.forEach(function(data) {
            let d = data.data();
                html += `<div class="chat-person d-flex align-items-center justify-content-between" ownerId="${d.ownerId}" ownerName="${d.ownerName}">
                            <div class="chat-name py-2 px-4">
                                <p class="no-margin text-dark">${d.ownerName}</p>
                                <p class="no-margin text-secondary text-truncate">${d.message}</p>
                            </div>
                        </div>`
            })
        } else {
            html += `<div class="alert alert-danger m-3">Belum ada obrolan</div>`
        }

        $(".chat-list").html(html);
        $(".chat-person").click(function() {
            let ownerId = $(this).attr('ownerId');
            let ownerName = $(this).attr('ownerName');

            getChat(userId, ownerId);

            $("#chat-send").attr('ownerName', ownerName);
            $("#chat-send").attr('ownerId', ownerId);
            
            $(".chat-content").show();
            $(".chat-list").slimScroll({scrollTo : 0, height: '0px'});
            $(".chat-content-list").slimScroll({scrollTo : 0, height: '340px'});
        })
    })

    $("#chat-owner").on('click', function() {
        let ownerId = $(this).attr('ownerId');
        let ownerName = $(this).attr('ownerName');

        getChat(userId, ownerId);

        $("#chat-send").attr('ownerName', ownerName);
        $("#chat-send").attr('ownerId', ownerId);

        $(".chat-box").css({'right': '15px'});
        $(".chat-content").show();
        $(".chat-list").slimScroll({scrollTo : 0, height: '0px'});
        $(".chat-content-list").slimScroll({scrollTo : 0, height: '340px'});
    })

    $("#chat-send").on('keydown', function(e) {
        let ownerName = $(this).attr('ownerName');
        let ownerId = $(this).attr('ownerId');
        let message = $(this).val();

        if(e.keyCode == 13) {
            sendChat(userId, userName, ownerId, ownerName, userFace, message);
        }
    })

    $(".chat-list").slimScroll({scrollTo : 0, height: '400px'});
    $(".chat-content-list").slimScroll({scrollTo : 0, height: '0px'});
    $(".chat-content").hide();

    $(".chat-bubble").click(function() {
        $(".chat-box").css({'right': '15px'});
    })

    $("#close-chat").click(function() {
        $(".chat-box").css({'right': `-${boxWidth}px`});
        $(".chat-content").hide();
        $(".chat-list").slimScroll({scrollTo : 0, height: '400px'});
        $(".chat-content-list").slimScroll({scrollTo : 0, height: '0px'});
    })
}

if($("#owner-chat-box").length) {
    let ownerId = $("#owner-chat-box").attr('ownerId');
    let ownerName = $("#owner-chat-box").attr('ownerName');

    $("#chat-field").hide();
    function getChat(userId, ownerId) {
        db.collection('chat').doc(`${ownerId}:${userId}`).collection('messages').orderBy('date', 'asc').onSnapshot((snapshot) => {
            let html = '<ul class="chat-list list-style-none px-3 pt-3">'
            snapshot.docs.forEach(function(data) {
                let d = data.data();

                if(d.sender != ownerId) {
                  html += `<li class="chat-item list-style-none mt-3">
                                <div class="chat-content d-inline-block pl-3">
                                    <div class="msg p-2 d-inline-block mb-1">${d.message}</div>
                                </div>
                            </li>`
                } else {
                  html += `<li class="chat-item odd list-style-none mt-3">
                                <div class="chat-content text-right d-inline-block pl-3">
                                    <div class="box msg p-2 d-inline-block mb-1">${d.message}</div>
                                    <br>
                                </div>
                            </li>`
                }
            })

            html += `</ul>`

            $(".chat-box").html(html);
            $("#chat-field").show();
            var scroll = $('.chat-box').prop('scrollHeight'); 
            $('.chat-box').slimScroll({scrollTo : scroll + 'px', height: 'calc(100vh - 111px)'});
        })
    }

    function sendChat(userId, userName, ownerId, ownerName, userFace, message) {
        let sender = [];
        sender[0] = parseInt(userId)
        sender[1] = parseInt(ownerId);

        db.collection('chat').doc(`${ownerId}:${userId}`).set({
          ownerName: ownerName,
          message: message,
          userName: userName,
          ownerId: parseInt(ownerId),
          userId: parseInt(userId),
          sender: sender,
          face: userFace,
          date: + new Date()
        });

        db.collection('chat').doc(`${ownerId}:${userId}`).collection('messages').doc().set({
          message: message,
          sender: parseInt(ownerId),
          date: + new Date()
        })

        $("#chat-send").val('');
    }

    db.collection('chat').where('sender', 'array-contains', parseInt(ownerId)).onSnapshot((snapshot) => {
        let html = ''
        if(snapshot.docs.length > 0) {
            snapshot.docs.forEach(function(data) {
            let d = data.data();
                html += `<li userId="${d.userId}" userName="${d.userName}" userFace="${d.face}">
                            <div class="message-center">
                                <a href="javascript:void(0)" class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                    <div class="user-img">
                                        <img src="${d.face}" class="img-fluid rounded-circle" style="height:40px" width="40px">
                                        <span class="profile-status online float-right"></span>
                                    </div>
                                    <div class="w-75 d-inline-block v-middle pl-2 py-3">
                                        <h6 class="message-title mb-0 mt-1">${d.userName}</h6>
                                        <span class="font-12 text-nowrap d-block text-muted text-truncate">${d.message}</span>
                                    </div>
                                </a>
                            </div>
                        </li>`
            })
        } else {
            html += `<li><div class="alert alert-danger m-3">Belum ada obrolan</div></li>`
        }

        $(".mailbox").html(html);
        $(".mailbox li").click(function() {
            let userId = $(this).attr('userId');
            let userName = $(this).attr('userName');
            let userFace = $(this).attr('userFace');

            $("#chat-send").attr('userName', userName);
            $("#chat-send").attr('userId', userId);
            $("#chat-send").attr('userFace', userFace);
            getChat(userId, ownerId);
        })
    })

    $("#chat-send").on('keydown', function(e) {
        if(e.keyCode == 13) {
            let userId = $(this).attr('userId');
            let userName = $(this).attr('userName');
            let userFace = $(this).attr('userFace');
            let message = $(this).val();

            sendChat(userId, userName, ownerId, ownerName, userFace, message);
        }
    })
}

if($("#account-card").length) {
    $(".account-menu a").click(function() {
        let target = $(this).attr("data-target");
        $(".account-menu a").removeClass('active');
        $(this).addClass('active');
        $(".account-card").addClass('d-none');
        $(target).removeClass('d-none');
    })
}

if($("#map-detail").length) {
    let lat = $("#map-detail").attr('lat');
    let long = $("#map-detail").attr('long');
    var mymap = L.map('map-detail').setView([lat, long], 13);
    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoicWRyMzExMTIiLCJhIjoiY2s5czN1M3E4MTE5dTNmbzN0dzlvMW84cCJ9.xISAyVMSyc9_MWS3-nf5vQ', {
        maxZoom: 18,
        id: 'mapbox/streets-v11',
        tileSize: 512,
        zoomOffset: -1,
        accessToken: 'pk.eyJ1IjoicWRyMzExMTIiLCJhIjoiY2s5czN1M3E4MTE5dTNmbzN0dzlvMW84cCJ9.xISAyVMSyc9_MWS3-nf5vQ'
    }).addTo(mymap);
    var marker = L.marker([lat, long]).addTo(mymap);
}

if($(".payment-daily").length) {
    $(".payment-daily button").click(function() {
        $("#pay-day").submit();
    })

    $(".payment-monthly button").click(function() {
        $("#pay-month").submit();
    })

    $(".payment-yearly button").click(function() {
        $("#pay-year").submit();
    })


    $(".filter-btn").click(function() {
        $(".filter-btn").removeClass('btn-primary text-white');
        $(".filter-btn").addClass('btn-outline-primary');
        $(this).removeClass('btn-outline-primary');
        $(this).addClass('btn-primary text-white');

        let elem = $(this).attr('data');
        $(".payment-daily,.payment-monthly,.payment-yearly").removeClass('d-none');
        $(".payment-daily,.payment-monthly,.payment-yearly").addClass('d-none');
        $(`.${elem}`).removeClass('d-none');
    });

    $("[name=check-in],[name=check-out]").on('change', function() {
        let cin = new Date($("[name=check-in]").val());
        let out = new Date($("[name=check-out]").val());

        if(cin >= out) {
            swal({title: "Error", text: "Tanggal check-out harus lebih besar", icon: "error"}).then(() => {
                window.location.reload();
            })
        }
 
        let price = $(".payment-daily").attr('price');

        let diff = out.getTime() - cin.getTime();
        diff = diff / (1000 * 3600 * 24);
        let total = diff * price;

        $(".payment-daily .table").html(`
            <tr>
                <td>Rp. ${numberWithCommas(price)} x ${diff} malam</td>
                <td class="text-right">Rp. ${numberWithCommas(total)}</td>
            </tr>
            <tr>
                <td><h5 class="font-weight-bold">Total</h5></td>
                <td class="text-right">Rp. ${numberWithCommas(total)}</td>
            </tr>
        `)

        $("#pay-day [name=duration]").val(diff)
        $("#pay-day [name=price]").val(total)
    })

    $(".payment-monthly [name=month]").on('change', function() {
        let month = $(this).val();

        $(".payment-monthly [name=plan]").html(
            `<option value="full">Penuh</option>
            <option value="${month}">${month}x Bayar</option>
            `
        );
    })

    $(".payment-yearly [name=year]").on('change', function() {
        let year = $(this).val();

        $(".payment-yearly [name=plan]").html(
            `<option value="full">Penuh</option>
            <option value="${year * 6}">2x Bayar (Tiap ${year * 6} bulan)</option>
            <option value="${year * 4}">3x Bayar (Tiap ${year * 4} bulan)</option>
            <option value="${year * 3}">4x Bayar (Tiap ${year * 3} bulan)</option>
            <option value="${year * 2}">6x Bayar (Tiap ${year * 2} bulan)</option>
            <option value="${year * 1}">12x Bayar (Tiap ${year * 1} bulan)</option>
            `
        )
    })

    $(".payment-monthly [name=plan],.payment-monthly [name=month]").on('change', function() {
        let price = $(".payment-monthly").attr('price');
        let value = $(".payment-monthly [name=plan]").val();
        let month = $(".payment-monthly [name=month]").val();
        if(value == 'full') {
            $(".payment-monthly table").html(`
                <tr>
                    <td>Biaya Sewa</td>
                    <td class="text-right">Rp. ${numberWithCommas(price * month)}</td>
                </tr>
                <tr>
                    <td><h5 class="font-weight-bold">Total</h5></td>
                    <td class="text-right">Rp. ${numberWithCommas(price * month)}</td>
                </tr>
            `)

             $("#pay-month [name=price]").val(price * month)
             $("#pay-month [name=duration]").val(1)
        } else {
            let html = '';
            let date = new Date();

            for(i = 1; i <= month; i++) {
                let setDate = 0;
                if(i == 1) {
                    setDate = date.setMonth(date.getMonth()+ 0);
                } else {
                    setDate = date.setMonth(date.getMonth()+ 1);
                }
                html += `
                <tr>
                    <td>Tagihan tanggal ${formatDate(setDate)}</td>
                    <td class="text-right">Rp. ${numberWithCommas(price)}</td>
                </tr>
                `
            }

            html += `<tr>
                        <td><h5 class="font-weight-bold">Total</h5></td>
                        <td class="text-right">Rp. ${numberWithCommas(price * month)}</td>
                    </tr>`

            $(".payment-monthly table").html(html);
            $("#pay-month [name=price]").val(price)
            $("#pay-month [name=duration]").val(month)
        }
    })

    $(".payment-yearly [name=plan],.payment-yearly [name=year]").on('change', function() {
        let price = $(".payment-yearly").attr('price');
        let value = $(".payment-yearly [name=plan]").val();
        let year = $(".payment-yearly [name=year]").val();
        if(value == 'full') {
            $(".payment-yearly table").html(`
                <tr>
                    <td>Biaya Sewa</td>
                    <td class="text-right">Rp. ${numberWithCommas(price * year)}</td>
                </tr>
                <tr>
                    <td><h5 class="font-weight-bold">Total</h5></td>
                    <td class="text-right">Rp. ${numberWithCommas(price * year)}</td>
                </tr>
            `)

             $("#pay-year [name=price]").val(price * year)
             $("#pay-year [name=duration]").val(1)
        } else {
            let html = '';
            let date = new Date(new Date().setMonth(new Date().getMonth() - 1));

            for(i = 1; i < 12 * year; i++) {
                let setDate = 0;
                setDate = date.setMonth(date.getMonth() + 1);
                if(i == 1) {
                    html += `
                            <tr>
                                <td>Tagihan tanggal ${formatDate(setDate)}</td>
                                <td class="text-right">Rp. ${numberWithCommas(Math.round(price * year / (year * 12 / value)))}</td>
                            </tr>
                            `
                } else {
                    if(i % value == 0) {
                        console.log(value)
                        html += `
                                <tr>
                                    <td>Tagihan tanggal ${formatDate(setDate)}</td>
                                    <td class="text-right">Rp. ${numberWithCommas(Math.round(price * year / (year * 12 / value)))}</td>
                                </tr>
                                `
                    }
                }
            }

            html += `<tr>
                        <td><h5 class="font-weight-bold">Total</h5></td>
                        <td class="text-right">Rp. ${numberWithCommas(price * year)}</td>
                    </tr>`

            $(".payment-yearly table").html(html);
            $("#pay-year [name=price]").val(Math.round(price * year / (year * 12 / value)))
            $("#pay-year [name=duration]").val(value)
        }

        $("#pay-year [name=year]").val(year)
    })
}

if($("#balance-card").length) {
    if(localStorage.getItem('transaction_id')) {
        $(".form-topup .btn-topup").prop('disabled', true);
        $("#balance-card .alert").removeClass('d-none');
    }

    $(".filter-box .filter-type-btn").click(function() {
        $(".filter-type-btn").removeClass('btn-primary text-white');
        $(".filter-type-btn").addClass('btn-outline-primary');
        $(this).removeClass('btn-outline-primary');
        $(this).addClass('btn-primary text-white');

        let balance = $(this).attr('type');
        $("[name=balance]").val(balance);
    })

    $(".btn-topup").click(function() {
        let balance = $("[name=balance]").val();
        let token = $("[name=_token]").val();

        $.ajax({
            type: 'post',
            url: url + '/pay/topup',
            data: '_token='+ token +'&balance=' + balance,
            success: function(data) {
                let payToken = data;
                snap.pay(data, {
                    onSuccess: function(data) {
                        swal({title: "Success", text: "Topup anda berhasil", icon: "success", buttons: { hapus: "OK" }})
                        location.reload();
                    },
                    onPending: function(data) {
                        localStorage.setItem('transaction_id', payToken);
                        localStorage.setItem('pendingBalance', balance);
                        $("#balance-card .alert").removeClass('d-none');
                        $(".form-topup .btn-topup").prop('disabled', true);
                        swal({title: "Maaf", text: "Silahkan selesaikan pembayaran anda", icon: "warning", buttons: { hapus: "OK" }})
                    },
                    onError: function(data) {
                        swal({title: "Error", text: "Pembayaran Gagal", icon: "error", buttons: { hapus: "OK" }})
                    }
                });
            }
        })
    })

    $(".btn-check").click(function() {
        let data = localStorage.getItem('transaction_id');
        let balance = localStorage.getItem('pendingBalance');
        snap.pay(data, {
            onPending: function(data) { console.log(data) },
            onError: function(data) {
                if(data.status_message[0] == 'transaction has been succeed') {
                        swal({title: "Success", text: "Topup anda berhasil", icon: "success", buttons: { hapus: "OK" }});
                        localStorage.removeItem('transaction_id');
                        localStorage.removeItem('pendingBalance');
                        $("#balance-card .alert").addClass('d-none');
                        $(".form-topup .btn-topup").prop('disabled', false);
                        location.reload();
                } else {
                    swal({title: "Error", text: "Pembayaran Gagal", icon: "error", buttons: { hapus: "OK" }})
                }
            }
        });
    })
}

if($("#datatable").length) {
    $("#datatable").DataTable();
}

if($(".viewUser").length) {
    $(".viewUser").click(function() {
        let userId = $(this).attr('data-id')
        $.ajax({
            type: 'get',
            url: `${url}/user/info/${userId}`,
            success: function(result) {
                $("#viewUserModal [name=name]").val(result.name);
                $("#viewUserModal [name=address]").val(result.address);
                $("#viewUserModal [name=phone]").val(result.phone);
                $("#viewUserModal [name=email]").val(result.email);
                $("#viewUserModal [name=dob]").val(result.dob);
                $("#viewUserModal #pic").attr('src', result.face);
                $("#viewUserModal").modal('show');
            }
        })
    })
}
