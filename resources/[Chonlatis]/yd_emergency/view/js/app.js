let alertId = 0;

window.onload = () => {
    window.addEventListener('message', e => {
        if (e.data.type === 'noty') {
            let title = e.data.title;
            let message = e.data.message;
            let number = e.data.number;
            let timeout = e.data.timeout;
            let image = e.data.image;

            alertId += 1;

            let template = `
                <div class="alert" id="${alertId}">
                    <div class="bg">
                        <div class="left">
                            ${number}
                        </div>
                        <div class="right">
                            <div class="header">
                                <img src="${image}" width="25px">
                                แจ้งเตือน
                            </div>
                            <div class="body">
                                <div>
                                    ${title}
                                </div>
                                <!--<div>
                                    ${message}
                                </div>-->
                                <div class="getter">
                                    กด <strong>Shift + ${number}</strong> เพื่อมาร์ค
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            `;

            let audio = new Audio('./alert.mp3');
            audio.volume = 0.5;
            audio.play();

            $('.alert-container').append(template);
            $('.alert-container').find(`#${alertId}`).fadeIn();

            let toRemove = alertId;
            let idNumber = number;
            setTimeout(() => {
                $('.alert-container').find(`#${toRemove}`).fadeOut();

                $.post('https://yd_emergency/removeQueue', JSON.stringify({
                    caseId: idNumber
                }));
            }, timeout);
        } else if (e.data.type === 'accepted') {
            let message = e.data.message;
            let timeout = e.data.timeout;

            alertId += 1;

            let template = `
                <div class="alert accept" id="${alertId}">
                    <div class="bg">
                        <div class="body">
                            <div class="f-center">
                                <ion-icon name="checkmark-circle-outline"></ion-icon>&nbsp;${message}
                            </div>
                        </div>
                    </div>
                </div>
            `;

            $('.alert-container').append(template);
            $('.alert-container').find(`#${alertId}`).fadeIn();

            let toRemove = alertId;
            setTimeout(() => {
                $('.alert-container').find(`#${toRemove}`).fadeOut();
            }, timeout);
        }
    });
};