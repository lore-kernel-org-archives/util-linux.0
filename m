Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:21905 "EHLO
	hunin.borkware.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945908AbWLVPTD (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 10:19:03 -0500
Subject: Re: splitting util-linux (was: kill)
From: Mark Rosenstand <mark@borkware.net>
To: Karel Zak <kzak@redhat.com>
Cc: Albert Cahalan <acahalan@gmail.com>, util-linux-ng@vger.kernel.org
In-Reply-To: <20061222102404.GU5971@petra.dvoda.cz>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com>
	 <20061220104547.GJ5971@petra.dvoda.cz>
	 <20061220214503.0BB4744007@Psilocybe.Update.UU.SE>
	 <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com>
	 <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz>
	 <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
	 <20061222102404.GU5971@petra.dvoda.cz>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 15:50:34 +0100
Message-Id: <1166799034.9775.10.camel@mjollnir.borkware.net>
Mime-Version: 1.0
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 2006-12-22 at 11:24 +0100, Karel Zak wrote:
> On Fri, Dec 22, 2006 at 01:12:54AM -0500, Albert Cahalan wrote:
> 
> > arch -- OK, though people use uname
> 
>  we have tried remove it from FC, but many users still use it.

Perhaps it could spew a deprecation warning referring to uname so
current users can be spotted, and lead to removal long-term.

