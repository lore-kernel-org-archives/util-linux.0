Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:37321 "EHLO
	homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751441Ab1LINNq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Dec 2011 08:13:46 -0500
Subject: RE: [PATCH] prlimit: return proper type
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0D87014694@MCHP058A.global-ad.net>
References: <1323375559.2562.2.camel@offbook>
	 <7856072A9D04C24B82DFE2B1112FE38A0D87014694@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Dec 2011 14:13:10 +0100
Message-ID: <1323436390.2522.0.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'd rather have the function return a proper status and not use it than
not return anything.

Thanks,
Davidlohr

On Fri, 2011-12-09 at 10:48 +0100, Voelker, Bernhard wrote:
> Davidlohr Bueso wrote:
> 
> > The add_prlim() function's definition currently returns a bogus structure.
> 
> > -static struct prlimit *add_prlim(char *ops, struct list_head *lims, size_t id)
> > +static int add_prlim(char *ops, struct list_head *lims, size_t id)
> 
> Why not void and remove that return stmt?
> The return code is not used anywhere.
> 
> Have a nice day,
> Berny


