Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:62943 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932181AbcDFMeI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 08:34:08 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 1/2] tests: test_md5 prints md5sum only
Date: Wed, 6 Apr 2016 13:33:58 +0100
Cc: util-linux@vger.kernel.org
References: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de> <20160406122615.foxdi772wqthsxfc@ws.net.home>
In-Reply-To: <20160406122615.foxdi772wqthsxfc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604061433.59553.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 06 April 2016, Karel Zak wrote:
> On Wed, Apr 06, 2016 at 12:30:17PM +0200, Ruediger Meier wrote:
> > We want to to use it for other tests without depending on
> > gnu md5sum and without cut or awk.
>
> It does not seem like anything critical, both patches applied to the
> next branch (will be in v2.29). Thanks.

That's ok. These patches do not fix any existing problem yet. They are 
just one minor step to remove coreutils dependency from out tests. We 
would still need to fix usage of readlink, seq and truncate. 

cu,
Rudi
