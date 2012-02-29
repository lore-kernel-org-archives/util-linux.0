Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40404 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932628Ab2B2Ng0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Feb 2012 08:36:26 -0500
Date: Wed, 29 Feb 2012 14:36:19 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] lslocks: new command
Message-ID: <20120229133619.GA8471@x2.net.home>
References: <1330357315.2540.5.camel@offbook>
 <7856072A9D04C24B82DFE2B1112FE38A0F0AFAD64D@MCHP058A.global-ad.net>
 <1330363740.2540.8.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330363740.2540.8.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 27, 2012 at 06:29:00PM +0100, Davidlohr Bueso wrote:
>  misc-utils/lslocks.c |  546 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 546 insertions(+), 0 deletions(-)
>  create mode 100644 misc-utils/lslocks.c

 Applied with some minor changes, thanks!

 Please, next time keep your patches consistent -- for example if you
 add lslock.c to  Makefile.am then the file lslock.c should be already
 exist in the tree.
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
