Return-Path: nefelim4ag@gmail.com
MIME-Version: 1.0
In-Reply-To: <47fb6e30-50a8-29a2-810e-5c872f76813d@gmail.com>
References: <90fb3b4a-38b8-17fc-f1b6-03e8c23eb808@gmail.com>
 <CAGqmi75B7yzQp-EWBnbjXgSpbNZAsXah1WtQqPUOE6_NjZRwhA@mail.gmail.com>
 <CAGqmi75=cWbRBxU-DkxyXffQSjy8f5jxA_Hx6oVqUrLU_sU9GA@mail.gmail.com> <47fb6e30-50a8-29a2-810e-5c872f76813d@gmail.com>
From: Timofey Titovets <nefelim4ag@gmail.com>
Date: Tue, 23 Jan 2018 21:33:46 +0300
Message-ID: <CAGqmi77Fzd9eMAL7=XdiLiT6dEKAgQWUtnyPaAk8AiiSfhbmxA@mail.gmail.com>
Subject: Re: Patch to add support for lz4hc and deflate optimization
 algorithms in zramctl.
To: Libor Bukata <lbukata@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>, Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

I mean, that you can use GitHub and pull request for that change =)
Instead of mail and patch in attachment

2018-01-23 20:57 GMT+03:00 Libor Bukata <lbukata@gmail.com>:
> Thank you for your comments. I added the support for 842 compression
> algorithm. The included patch is signed and tested on the latest
> versions of both Git repositories:
>
> git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
> git://github.com/karelzak/util-linux.git
>
> I am not sure what you meant by: "Also, use
> https://github.com/karelzak/util-linux and PR, .."
> If it is important, please do not hesitate to provide me more
> information in order to fix it.
>
> Have a nice day,
> Libor.
>
> Dne 23.1.2018 v 14:21 Timofey Titovets napsal(a):
>> Also, use https://github.com/karelzak/util-linux and PR,
>> also add comment + Signed-off-by to patch.
>>
>> 2018-01-23 11:08 GMT+03:00 Timofey Titovets <nefelim4ag@gmail.com>:
>>> https://patchwork.kernel.org/patch/9144717/
>>>
>>> I think your patch miss support of 842 algo
>>>
>>> 2018-01-22 23:45 GMT+03:00 Libor Bukata <lbukata@gmail.com>:
>>>> Dear developers of Linux utils,
>>>>
>>>> I extended the zramctl utility to handle also lz4hc and deflate formats.
>>>> The patch is included in the attachment. Thank you in advance for your
>>>> comments.
>>>>
>>>> Kind regards,
>>>> Libor Bukata.
>>>
>>>
>>> --
>>> Have a nice day,
>>> Timofey.
>>
>>
>



-- 
Have a nice day,
Timofey.
