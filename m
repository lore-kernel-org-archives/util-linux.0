Return-Path: msuchanek@suse.de
Date: Wed, 14 Jun 2017 15:59:22 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Alexander Graf <agraf@suse.de>, sbrabec@suse.com
Subject: Re: [PATCH] lscpu: dmi: return HYPER_NONE when detection fails
Message-ID: <20170614155922.7a5b44b0@kitsune.suse.cz>
In-Reply-To: <20170613102418.l6uhgpmqabacih3g@ws.net.home>
References: <20170612153228.2766-1-msuchanek@suse.de>
	<20170613102418.l6uhgpmqabacih3g@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 13 Jun 2017 12:24:18 +0200
Karel Zak <kzak@redhat.com> wrote:

> On Mon, Jun 12, 2017 at 05:32:28PM +0200, Michal Suchanek wrote:
> > There is weird mix of logic in lscpu-dmi.c which sometimes returns
> > 0 and sometimes -1 on error. Since most checks are if (rc) goto
> > done; this bails out early on error skipping some detection
> > methods. Further, in lscpu.c all following detections are guarder
> > by if(hyper) so returnning -1 causes all following methods to be
> > skipped. The hyper value is used as array index so -1 is out of
> > bounds.  
> 
> Yes, that's bug.
> 
 
> Not applied.
> 
> I don't think this is correct. We need to differentiate between
> 
>  1/ DMI not in /sys   (rc == -1)
>  2/ DMI available, but nothing detected (rc == HYPER_NONE)
> 
> For the 1/ we need to try /dev/mem.
> 
> I did some changes to the code to make it more robust. Now
> read_hypervisor_dmi() does not return -1 at all.
> 
> Please, test it. Thanks!

Looks ok. This does not crash on arm64 with the broken kernel and we
will eventually get testing of the other archs as well. Not returning
-1 should fix them.

Thanks

Michal
