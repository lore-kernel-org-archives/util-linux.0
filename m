Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [EXT] Re: ready for v2.32 ?
Date: Tue, 27 Feb 2018 00:01:29 +0100
Cc: "John Groves (jgroves)" <jgroves@micron.com>,
 "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <201802262216.01925.ruediger.meier@ga-group.nl> <1519685049171.25700@micron.com> <20180226225006.rslgrlgsmphsyhqh@ws.net.home>
In-Reply-To: <20180226225006.rslgrlgsmphsyhqh@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201802270001.29545.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 26 February 2018, Karel Zak wrote:
> On Mon, Feb 26, 2018 at 10:44:12PM +0000, John Groves (jgroves) wrote:
> > Doh! Mpool stores its metadata as little endian, and rigorously
> > uses le32_to_cpu and the like to move on-media structures to & from
> > memory.
> >
> > le32_to_cpu(osd->osb_cksum1) would be the correct way to handle it.
>
> Fixed. Thanks for quick reply!

Always nice to see when it was worth to ask for adding a test case :)

cu,
Rudi
