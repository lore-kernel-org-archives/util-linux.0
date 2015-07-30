Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20150730095542.GK6865@ws.net.home>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
	<20150730095542.GK6865@ws.net.home>
Date: Thu, 30 Jul 2015 11:31:10 +0100
Message-ID: <CAG27Bk2vPWETKVkXMs7qM0_rFGsMZbvNpMaiDkQi80QPAhZd1w@mail.gmail.com>
Subject: Re: [PATCH 00/12] pull: minix updates
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 30 July 2015 at 10:55, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Jun 24, 2015 at 09:15:07AM +0100, Sami Kerola wrote:
>> The patch 0001 is not re-submitted.  It is the change Joshua Hudson sent
>> to mail list couple days ago.  The rest are new changes, and they are
>> also available from my remote branch 'minix'.
>
> Merged from inbox (the stuff on github seems broken, see
> https://github.com/kerolasa/lelux-utiliteetit/commit/8f15af61755fd0f2ee03f34f20ee8dccfd6f529a
> where is also some bus-server.c ...).

Oh garbage. Well, thank you for applying from mail list.

> It would be really really nice to have regression tests before
> v2.27-rc2, I guess we need to test all versions (1,2,3) and all
> possible namelens with mkfs.minix, fsck.minix and mount(8).

I started work to add tests last evening. I'm sure minix checks
are done within week, or two if paid work is causing me be too
tired at evenings.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
