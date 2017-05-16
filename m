Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbdEPLBo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 May 2017 07:01:44 -0400
Date: Tue, 16 May 2017 13:01:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Message-ID: <20170516110139.v63qiov2ndxw2gwa@ws.net.home>
References: <201705121638.59416@pali>
 <20170515100940.lggq2um6xt3dg66p@ws.net.home>
 <20170515123845.GA10015@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170515123845.GA10015@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 15, 2017 at 02:38:45PM +0200, Pali Rohár wrote:
> But question remain what to do with UUID.

It seem generated UUID is libblkid feature and another tools/systems
don't use anything like UUID for UDF, right?

If yes... then we can keep it unchanged, generate UUDI in the same way
as now (hexadecimal digits). The "OSTA Unicode fix" maybe be used for
LABEL= (etc) only. I guess nothing forces use to generate UUIDs from 
decoded VolSetId.

Anyway, UUID has to be printable.

> I suggest to include all UDF changes in one release, so "breakage" would
> be just between two versions. So if above Label/UUID changes would not
> be ready for next release, I would suggest to postpone currently merged
> UDF changes.

Yes.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
