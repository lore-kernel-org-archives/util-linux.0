Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20141215091540.GV19904@x2.net.home>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
	<20141215091540.GV19904@x2.net.home>
Date: Mon, 15 Dec 2014 10:38:18 +0000
Message-ID: <CAG27Bk1K3_aXM5KCVkT5SJE_vLsx+vBE=VF9PYY04QbYQ+-=eQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] pull: AddressSanitizer round II
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 15 December 2014 at 09:15, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Nov 30, 2014 at 01:57:32PM +0000, Sami Kerola wrote:
>> Here comes the second set of changes to enable AddressSanitizer one day
>> in future.  These changed does not include update to travis-functions, as
>> demonstrated below, due reason explained later.  The environment changes
>> in the diff are useful for other who want to try ASAN compilations.
>
> Hi Sami, do you plan to update these patches? I'd like to release -rc1
> this month :-)

Hi Karel,

Sorry, I have been a bit lazy with ASAN patch series. I'll try to do
the required small fixes in beginning part of the week, and send
replies what was changed.

BTW nice to know we are getting closer to a release.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
