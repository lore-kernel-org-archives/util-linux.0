Return-Path: <SRS0=B5TI=SZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79D4C10F03
	for <util-linux@archiver.kernel.org>; Tue, 23 Apr 2019 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A862221738
	for <util-linux@archiver.kernel.org>; Tue, 23 Apr 2019 19:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Md/o7DO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfDWT2H (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:28:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43766 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWT2G (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Apr 2019 15:28:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3NJJGoO182786;
        Tue, 23 Apr 2019 19:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/kqphIvHH2NlFDk+hg8iPJrVo66ec6YSz9zT6KgtkUM=;
 b=Md/o7DO0uK6d6yKlWAXJ+FdF4FqUXCFr7h79AkFfLTEKmz1J9/rI/9mPgxRWtl9XsZZF
 iBEorZlb1O5iXoNwJCJrcHDeG7k8xIfqNbVM26EPKaH6PczT6MzBh0FBSj05+XRDTabU
 lTaDqG+61nTcF0gAszgLCp3CNyy70rwAyVn+sPr9K6DobXoYJpZbDebrP1/+E4oOTdVz
 en9YwCwoYs4hrfLlXDIeZnI3PqAZds23Y3ct6LdaSOJAfkxDYg3pdYKQC5/VPagBzWOM
 5yAtKDEmzevU8rZi3viQDcERLLKeY7RV1stAn8M8Vca1xMfKcpFxLmwLP9F0hIcGJJaC VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2ryrxcxg73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 19:28:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3NJQjVw118589;
        Tue, 23 Apr 2019 19:28:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s0dweenpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 19:28:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3NJS0mZ020122;
        Tue, 23 Apr 2019 19:28:00 GMT
Received: from localhost (/10.145.179.89)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Apr 2019 12:28:00 -0700
Date:   Tue, 23 Apr 2019 12:27:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     util-linux@vger.kernel.org, Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH v2] fstrim: document kernel return minlen explicitly
Message-ID: <20190423192758.GA182714@magnolia>
References: <1556031508-18850-1-git-send-email-wshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556031508-18850-1-git-send-email-wshilong1991@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904230136
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904230136
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 23, 2019 at 11:58:28PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> Filesystem will modify @minlen according to its
> block size etc, and will return actual unit
> to userspace, document it into manpage.
> 
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> v1->v2:
> better explain as darrick suggestion..
> ---
>  sys-utils/fstrim.8 | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
> index f7e7aa9ef..c6ecca706 100644
> --- a/sys-utils/fstrim.8
> +++ b/sys-utils/fstrim.8
> @@ -76,10 +76,11 @@ the end of the filesystem.
>  .IP "\fB\-m, \-\-minimum\fP \fIminimum-size\fP"
>  Minimum contiguous free range to discard, in bytes. (This value is internally
>  rounded up to a multiple of the filesystem block size.)  Free ranges smaller
> -than this will be ignored.  By increasing this value, the fstrim operation
> -will complete more quickly for filesystems with badly fragmented freespace,
> -although not all blocks will be discarded.  The default value is zero,
> -discarding every free block.
> +than this will be ignored and fstrim will adjust the minimum if it's smaller than
> +the device's minimum, and report that (fstrim_range.minlen) back to userspace.
> +By increasing this value, the fstrim operation will complete more quickly for
> +filesystems with badly fragmented freespace, although not all blocks will be
> +discarded.  The default value is zero, discarding every free block.
>  .IP "\fB\-v, \-\-verbose\fP"
>  Verbose execution.  With this option
>  .B fstrim
> -- 
> 2.21.0
> 
