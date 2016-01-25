Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <CAG27Bk26z9GmKnMyE-dffa13F1nRKPMPvdWzpASpJo8ONF_=YQ@mail.gmail.com>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
	<20160120103042.clphjleuiesjrl52@ws.net.home>
	<56A1596C.3060507@prgmr.com>
	<56A25241.8050000@imap.cc>
	<56A27F92.6020309@prgmr.com>
	<CAG27Bk1xN6RccvCKwurdftkHkvS86Mi5VnA-8UiP7Y0peuh02A@mail.gmail.com>
	<20160123162241.pwvqxyfm4qv2apgo@ws.net.home>
	<CAG27Bk26z9GmKnMyE-dffa13F1nRKPMPvdWzpASpJo8ONF_=YQ@mail.gmail.com>
Date: Mon, 25 Jan 2016 19:55:07 +0000
Message-ID: <CAG27Bk2ieE1nSVXt65D41L9s47vemLpBL4XkgQzXer4y4hHepg@mail.gmail.com>
Subject: Re: [PATCH] mkswap: Add warnings for insecure device permissions/owners
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Sarah Newman <srn@prgmr.com>, Tilman Schmidt <tilman@imap.cc>,
        "Wayne R. Roth" <wayneroth42@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 24 January 2016 at 11:09, Sami Kerola <kerolasa@iki.fi> wrote:
> On 23 January 2016 at 16:22, Karel Zak <kzak@redhat.com> wrote:
>> On Fri, Jan 22, 2016 at 10:03:47PM +0000, Sami Kerola wrote:
>>> Alternatively one could make swapon to get rid of all permission bits
>>> and set ownership to UID 0 by default when ever it activates a
>>> swapfile. How about that.
>>
>> Not sure if want to change any permissions on the fly, it would be
>> better to reject files (by swapon) with insecure permissions and
>> require something like --force for crazy users who wants to ignore
>> this problem.
>
> Why not completely optional?
>
> $ swapon --path-permissions [ignore|complain|stop|fix]
>
> Current default is 'complain', and it feels about right.

Something like this.

https://github.com/kerolasa/lelux-utiliteetit/commit/d79b3cdbe4e61b7e10d595dec4d4e299c8300c9e

Notice that the change above is wrote on top of another change, that
added swapon control structure.

https://github.com/kerolasa/lelux-utiliteetit/commit/4d510f769de438092558f51430f3b195f328ef0e

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
