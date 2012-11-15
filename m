Return-Path: gladkov.alexey@gmail.com
Message-ID: <50A4B774.4010005@gmail.com>
Date: Thu, 15 Nov 2012 13:35:48 +0400
From: Alexey Gladkov <gladkov.alexey@gmail.com>
MIME-Version: 1.0
To: Petr Pisar <ppisar@redhat.com>
CC: util-linux@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Karel Zak <kzak@redhat.com>
Subject: Re: vlock command
References: <20121114103509.GD1835@x2.net.home> <50A37AD8.6060601@gmail.com> <20121114122610.GF1835@x2.net.home> <20121114233117.GD20303@altlinux.org> <50A48F5F.3090404@gmail.com> <20121115075253.GA26255@x2.net.home> <20121115084821.GB1877@dhcp-0-146.brq.redhat.com>
In-Reply-To: <20121115084821.GB1877@dhcp-0-146.brq.redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

15.11.2012 12:48, Petr Pisar wrote:
> It's similar but insufficient. The difference between your clear_str[]
> = "\33[H\33[J" and my string is my way clears scroll-back buffer of Linux
> virtual terminal too. This prevents from reading history using Shift-PgUp
> while the terminal is locked. Read current console_codes(4) page, especially
> search for word "buffer".
> 
> So what I ask is to prepend "\33[3J" to your clear_str[]. This even users with
> older kernel not implementing this code get console cleared.

Sounds reasonable.

> If I understand the code correctly, you clear screen only if it's a virtual
> terminal. I have no idea how usefull is vlock on other terminals (I use
> "screen" there), so I do not request any change in this matter.

Ok. This is what I wanted to find out.

Guys, I want to release the new version of kbd next month. This will
be the first kbd release with the vlock. Do you have any more
suggestions on vlock?

-- 
Rgrds, legion
