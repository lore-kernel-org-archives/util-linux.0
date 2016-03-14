Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] Revert "Revert "tests: start script/race test only when --force specified""
Date: Mon, 14 Mar 2016 12:49:40 +0100
Cc: Matthias Brugger <mbrugger@suse.com>, util-linux@vger.kernel.org
References: <1457455978-8530-1-git-send-email-mbrugger@suse.com> <20160309104340.axpsgrvhf2o3llkh@ws.net.home>
In-Reply-To: <20160309104340.axpsgrvhf2o3llkh@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603141249.40485.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 09 March 2016, Karel Zak wrote:
> On Tue, Mar 08, 2016 at 05:52:58PM +0100, Matthias Brugger wrote:
> > +# Don't execute this test by default, --force required
> > +TS_OPTIONAL="yes"
>
>  I have marked the test by
>
>     TS_KNOWN_FAIL="yes
>
>  it seems better than disable the test.

While we are at it, IMO we should finally disable libmount/lock too 
(TS_OPTIONAL).

It can be very slow and often fails. Last week I was waiting 2 hours for 
a failure on qemu/ppc. The whole system was unusable during the test. 
Don't know if this can be fixed in a better way.

Since I've never seen failures on travis we could force this test there.

cu,
Rudi
