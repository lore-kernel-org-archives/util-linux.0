Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 02/12] dmesg: move get_boot_time() to lib/timeutils
Date: Tue, 6 May 2014 15:42:44 +0200
Cc: util-linux@vger.kernel.org
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi> <201405061200.00836.sweet_f_a@gmx.de> <20140506112054.GP5962@x2.net.home>
In-Reply-To: <20140506112054.GP5962@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405061542.45205.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 06 May 2014, Karel Zak wrote:
> On Tue, May 06, 2014 at 12:00:00PM +0200, Ruediger Meier wrote:

> > clock_gettime() needs -lrt on some systems. That's why we had
> > dmesg_LDADD += -lrt. Now every binary which links against libcommon
> > needs that.
>
>  Fixed, I have moved get_boot_time() outside libcommon.

Thanks, you still have forgotten to commit the new header
  include/boottime.h

cu,
Rudi
