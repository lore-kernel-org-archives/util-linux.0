Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdEQHTq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 May 2017 03:19:46 -0400
Date: Wed, 17 May 2017 09:19:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org, Steve Kenton <skenton@ou.edu>,
        =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <xvlady00@stud.feec.vutbr.cz>,
        Jan Kara <jack@suse.cz>
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Message-ID: <20170517071940.kidsz5fqzk2xchhd@ws.net.home>
References: <201705121638.59416@pali>
 <20170515100940.lggq2um6xt3dg66p@ws.net.home>
 <201705170017.19752@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201705170017.19752@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 17, 2017 at 12:17:19AM +0200, Pali Rohár wrote:
> Fix for all UDF strings except UUID is in this pull request:
> https://github.com/karelzak/util-linux/pull/438
> 
> I hope it is correct now. UDF image with "Ã¿" is added to tests.

Thanks! Applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
