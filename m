Return-Path: <SRS0=TRZh=VN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B158BC7618F
	for <util-linux@archiver.kernel.org>; Tue, 16 Jul 2019 14:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B952173B
	for <util-linux@archiver.kernel.org>; Tue, 16 Jul 2019 14:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yh3OjUKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfGPOeG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:34:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfGPOeG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 Jul 2019 10:34:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GEXWCp118682;
        Tue, 16 Jul 2019 14:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=bw/qognzU2yOtQ60sXnIKuFMefxpvShDKTWGL2pQ/pI=;
 b=yh3OjUKcL5279xlessO6OX+KK80XOEpITJMep+YNsBTZXmnTatmtr1x7SyqXwHhNvGMT
 ozBTvyMlmsnyP55shWU8pnaM3Vm9iitJDy8btIkzNUEvYwgL+6wpT3c2NZwCt4kI+/Pj
 GHQuBROC74FszV8/0vcd3fJMQgRKxmpCxB5asuHYo2h4rT1SIK3Z8CX3OjGCcxR2vRFf
 aZncrFn5fJalp712nWaP+K/eyZG8lN6HR8vdZF3R6gG6DZ517yE5ADtD8+kkMSpTnI/O
 OHs7txLA/KS/VYSCqqTBBLD8TBSf5iypTYOiUhcqt5mWQehJNA4hHHDfu+gU5+fBqLwy PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tq7xqvuy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:34:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GEXIuQ002161;
        Tue, 16 Jul 2019 14:34:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tq5bcex95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:34:01 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GEY05H013672;
        Tue, 16 Jul 2019 14:34:01 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 14:34:00 +0000
To:     Istvan Gabor <suseuser04@gmail.hu>
Cc:     Util linux <util-linux@vger.kernel.org>
Subject: Re: fdisk does not allow overwrite default/suggested value
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
References: <55e1e62f0a4c14c93245292c2a62d789@gmail.hu>
Date:   Tue, 16 Jul 2019 10:33:58 -0400
In-Reply-To: <55e1e62f0a4c14c93245292c2a62d789@gmail.hu> (Istvan Gabor's
        message of "Tue, 16 Jul 2019 15:10:26 +0200")
Message-ID: <yq1k1ci1221.fsf@mkp.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=860
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160179
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=967 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160179
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


Istvan,

> https://linux-blog.anracom.com/2018/12/03/linux-ssd-partition-alignment-problems-with-external-usb-to-sata-controllers-i/

First of all, the ATA protocol can only express logical and physical
block sizes. So the optimal I/O size is always 0 when a disk is
connected via a "native" ATA controller.

USB storage, however, is a SCSI protocol. In that configuration it is up
to the USB bridge device to translate properties reported by the
attached ATA device to the relevant fields in the SCSI protocol. And
this is where several devices get it wrong (despite a fairly
comprehensive document describing how each field should be translated).

The SCSI block storage protocol permits reporting an optimal I/O
size. Since there is no corresponding ATA parameter, it means that the
value in your case inevitably comes from the USB bridge firmware. There
is nothing to base this value on from the ATA device itself, so the
bridge firmware authors either made it up or forgot to zero the field.

As a result of reports similar to the one above, I added an additional
heuristic to the SCSI disk driver code a while ago. The kernel will now
reject a device-reported optimal transfer size if it is not a multiple
of the physical block size. So in the buggy USB-SATA bridge case above
the optimal transfer size should be reported to user space as 0 and
therefore fdisk should align on a 4096-byte (physical block size)
boundary.

Note that this is somewhat orthogonal to your request about being able
to override the reported values in fdisk. I just thought some of the
text in the links you posted warranted clarification.

The question is why your kernel does not have the patch adding this
additional heuristic?

-- 
Martin K. Petersen	Oracle Linux Engineering
