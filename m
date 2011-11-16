Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx11-mx.siemens-enterprise.com ([62.134.46.9]:37353 "EHLO
	senmx11-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376Ab1KPM7s convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 07:59:48 -0500
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>, Bernhard Voelker <mail@bernhard-voelker.de>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Wed, 16 Nov 2011 13:59:45 +0100
Subject: RE: [PATCH 10/15] prlimit: refactor code: separate modify and show
	clearly
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D86E24B57@MCHP058A.global-ad.net>
References: <4EC07375.20005@bernhard-voelker.de>
 <20111116125147.GH7916@nb.net.home>
In-Reply-To: <20111116125147.GH7916@nb.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> On Mon, Nov 14, 2011 at 02:48:37AM +0100, Bernhard Voelker wrote:
> >  struct prlimit {
> >  	struct rlimit rlim;
> > -	int found;
> >  	struct prlimit_desc *desc;
> >  	int modify;
> > +	int show;
> >  };
> 
>  I think that 'modify == 0' means 'show'. It's strange to add two
>  variables to differentiate between two states.

As modifying and showing a limit was done in the same place, and
as the two actions are now separated (at least) more, 'modify == 1'
means the the limit is changed while 'show == 1' means the limit
has to be displayed. (In the previous code, the array item was only
processed if it was on the command line via the "n" loop.

Berny