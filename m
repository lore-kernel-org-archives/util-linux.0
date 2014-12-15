Return-Path: will.johansson@gmail.com
MIME-Version: 1.0
In-Reply-To: <20141215091931.GW19904@x2.net.home>
References: <1418179231-21326-1-git-send-email-will.johansson@gmail.com>
	<20141215091931.GW19904@x2.net.home>
Date: Mon, 15 Dec 2014 03:46:55 -0800
Message-ID: <CAE83jyxVG_CKR6rzmdO==rJB7aA8kWasXvXyK_PW8C6SAbzLAg@mail.gmail.com>
Subject: Re: login-utils: Enable building util-linux against OpenPAM
From: Will Johansson <will.johansson@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

Thanks for applying. I have a small patch for _HAVE_UT_TV incoming in
a few minutes.

Turns out it was because musl-libc doesn't define _HAVE_UT_TV, even
though musl-libc's utmp struct does have a ut_tv field. There are two
options: 1.) I could patch upstream musl-libc to define _HAVE_UT_TV or
2.) detect musl-libc somehow. I think I prefer the first option.

Thanks again,

Will

On Mon, Dec 15, 2014 at 1:19 AM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Dec 09, 2014 at 06:40:30PM -0800, Will Johansson wrote:
>> I recently experimented with cross-compiling for embedded devices, and
>> sought to try out util-linux with OpenPAM instead of Linux-PAM because
>> OpenPAM was simpler to cross-compile. Unfortunately for me, it did not
>> work out of the box, so I decided to try to patch util-linux to support
>> compiling against OpenPAM. Turned out to be a fairly simple exercise.
>>
>> This is the fruit of my efforts. There is a caveat, which I will
>
>  Applied, thanks.
>
>> be happy to address if it's a problem. The patch's configuration does
>> not support building if you happen to have both Linux-PAM and OpenPAM
>> in your build paths. I could update it to prefer Linux-PAM by default.
>> I'm not sure how it'd would work if OpenPAM libraries is also in the
>> search path, as -lpam is used by both Linux-PAM and OpenPAM (probably
>> undefined behavior).
>>
>> Either way, it should compile fine against Linux-PAM and OpenPAM.
>> There are some unused variables in login.c, but seems to have to do
>> with _HAVE_UT_TV, which is not the case in my configuration. I'm
>> more than happy to provide a separate patch to wrap the unused
>> variables with an #ifdef _HAVE_UT_TV.
>
>  I don't have OpenPAM, so I'm not able to verify usability, but it
>  would be nice to have build without warnings.
>
>     Karel
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com



-- 
Will Johansson
