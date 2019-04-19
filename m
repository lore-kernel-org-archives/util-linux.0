Return-Path: <SRS0=YmP7=SV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D21C282E0
	for <util-linux@archiver.kernel.org>; Fri, 19 Apr 2019 21:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00640208C0
	for <util-linux@archiver.kernel.org>; Fri, 19 Apr 2019 21:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="16xpCo96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfDSVPe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:15:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37892 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSVPe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 19 Apr 2019 17:15:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3JFEBSI054240;
        Fri, 19 Apr 2019 15:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=+VGTT7f5uemukG9QAWoN2VdDtnl0x+lSJqtAtV2q1z0=;
 b=16xpCo966qrw1+pKF6SeVtLLJeTErtAVqp4cplMZznEOgCLELawnOczxMuhMQtEmlRNQ
 8GtdRzKnJfS4PSJ+X1uoJx3KncMw22EY4JaU6D0CHS34BM+9LQvvsQZR5XwCQs1RatLH
 fpadP6bSYoDEDXGhW31pNaw2kfNgOk9awYEfUZtx9GNBouaA/F8KRiV763IoT50GSjZK
 Qr0q1zObqi+Pe4l0x+4qZx28sx97R6F3g8JzZK1KWbkGqTjAoHFrbDdgWWVBvHwCUYrA
 Gc+GHex1j2cV4Ekl/b7jT5G12uegeHy6L8jfxkSqQhqDVOumruxho/3CfEP3goTfu9bY ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2rusnfcacx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 15:16:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3JFGDp5017827;
        Fri, 19 Apr 2019 15:16:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2rwe7bjfm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 15:16:13 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3JFG9iW009735;
        Fri, 19 Apr 2019 15:16:10 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Apr 2019 08:16:09 -0700
Date:   Fri, 19 Apr 2019 08:16:11 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     util-linux@vger.kernel.org, Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH] fstrim: document kernel return minlen explictly
Message-ID: <20190419151611.GA6755@magnolia>
References: <1555684640-23615-1-git-send-email-wshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555684640-23615-1-git-send-email-wshilong1991@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9232 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904190113
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9232 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904190113
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Apr 19, 2019 at 11:37:20PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> Filesystem will modify @minlen according to its
> block size etc, and will return actual unit
> to userspace, document it into manpage.
> 
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  sys-utils/fstrim.8 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
> index f7e7aa9ef..10ef8bc23 100644
> --- a/sys-utils/fstrim.8
> +++ b/sys-utils/fstrim.8
> @@ -76,10 +76,10 @@ the end of the filesystem.
>  .IP "\fB\-m, \-\-minimum\fP \fIminimum-size\fP"
>  Minimum contiguous free range to discard, in bytes. (This value is internally
>  rounded up to a multiple of the filesystem block size.)  Free ranges smaller
> -than this will be ignored.  By increasing this value, the fstrim operation
> -will complete more quickly for filesystems with badly fragmented freespace,
> -although not all blocks will be discarded.  The default value is zero,
> -discarding every free block.
> +than this will be ignored and kernel shall return modified value(fstrim_range.minlen)

Overly long line, and perhaps there should be a space between "value"
and "(fstrim_range.minlen)"?

> +to userspace.

What is the modified value?  You might as well say that fitrim will
adjust the minimum if it's smaller than the device's minimum, and report
that back to userspace.

> By increasing this value, the fstrim operation will complete
> +more quickly for filesystems with badly fragmented freespace, although not
> +all blocks will be discarded.  The default value is zero, discarding every free block.

I prefer the practice of starting each sentence in the manpage source on
a new line so that the diff only reflects changes to actual content (and
not just reflowing of the text)... but the sys-utils maintainers clearly
don't employ that convention so I guess this is ok. :)

Thanks for putting together the documentation update.
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  .IP "\fB\-v, \-\-verbose\fP"
>  Verbose execution.  With this option
>  .B fstrim
> -- 
> 2.21.0
> 
