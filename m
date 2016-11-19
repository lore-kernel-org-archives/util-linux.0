Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.magicbluesmoke.com ([82.195.144.49]:60066 "EHLO
        mail.magicbluesmoke.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbcKSNPo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 19 Nov 2016 08:15:44 -0500
Subject: Re: [PATCH V2] fallocate: add insert range support
To: Fabian Frederick <fabf@skynet.be>, util-linux@vger.kernel.org
References: <1479235946-4268-1-git-send-email-fabf@skynet.be>
Cc: Karel Zak <kzak@redhat.com>,
        Dongsu Park <dongsu.park@profitbricks.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
From: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>
Message-ID: <6af466cd-000e-2019-68e6-856256e2872a@draigBrady.com>
Date: Sat, 19 Nov 2016 13:15:40 +0000
MIME-Version: 1.0
In-Reply-To: <1479235946-4268-1-git-send-email-fabf@skynet.be>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 15/11/16 18:52, Fabian Frederick wrote:
> Based on patch 83cc932d7412
> ("fallocate: introduce an option -c to support COLLAPSE_RANGE")
> 
> This patch includes FALLOC_FL_INSERT_RANGE flag
> added to Linux kernel v4.1
> 
> Thanks to Pádraig Brady for insert range definition
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

+1 from me

thanks,
Pádraig
