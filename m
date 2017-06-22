Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:51770 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbdFVUth (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Jun 2017 16:49:37 -0400
Received: from tenfore.site ([92.195.15.151]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiDKt-1eBUMO2zid-00nS9T for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 22:49:35 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/13] misc: fix some broken exit codes
Date: Thu, 22 Jun 2017 22:49:34 +0200
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de> <1498099066-24235-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-4-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201706222249.35084.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 22 June 2017, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> These tools have special exit codes. They got changed mistakenly.

I've moved this patch to my other "exit-code" pull request.
Updated on github.
 
Both patch-sets are independent and rebased on master
branch

cu,
Rudi
