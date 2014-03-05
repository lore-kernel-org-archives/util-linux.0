Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbaCEKM3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 5 Mar 2014 05:12:29 -0500
Date: Wed, 5 Mar 2014 11:12:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: chcpu exit code?
Message-ID: <20140305101222.GB13353@x2.net.home>
References: <530F0972.3040205@bernhard-voelker.de>
 <20140228075355.GB4216@osiris>
 <20140228090418.GA2783@x2.net.home>
 <5314662F.2010801@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5314662F.2010801@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 03, 2014 at 12:23:27PM +0100, Bernhard Voelker wrote:
> On 02/28/2014 10:04 AM, Karel Zak wrote:
> >I think we can do something like this with chcpu, my suggestion is
> >
> >    0 - success
> >    1 - failure
> >   64 - partial success
> 
> +1

 Fixed. Thanks for your report.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
