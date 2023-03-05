Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8386C678DB
	for <util-linux@archiver.kernel.org>; Sun,  5 Mar 2023 23:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjCEX73 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 5 Mar 2023 18:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEX72 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2023 18:59:28 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Mar 2023 15:59:27 PST
Received: from pmta21.teksavvy.com (pmta21.teksavvy.com [76.10.157.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD1ED50D
        for <util-linux@vger.kernel.org>; Sun,  5 Mar 2023 15:59:27 -0800 (PST)
IronPort-SDR: 9AxHIbyJJhrTn/HQOqFkaMLxA3ao9q2PDx/R9xPRTQU7dRU8ntRL8BqKtoNJ0wScj5NzslDxWB
 /mRkKGg5HdKA==
X-IPAS-Result: =?us-ascii?q?A2GHBACLKwVk/8vgpUVaHgEBCxIMQAmBOwuEfKFPk3cPA?=
 =?us-ascii?q?QEBAQEBAQEBCUQEAQEEijQmNwYOAQIEAQEBAQMCAwEBAQEFAQEBBQEBAQEBA?=
 =?us-ascii?q?QYEAgKBGYUvOQ2EXSyCBBMGAQE4gVCFXLI4gQEzgQGCCAEBBp1JgV4JgUABk?=
 =?us-ascii?q?XGBSUSBFTaBQYFxhRGFcpcbgTR2gSEOSnOBBwIJAhFrgRIIZ4IAQQIPaAsOg?=
 =?us-ascii?q?Qc3AwkDBwUsHUADCxgNUBMsNRQhXmwvEhIFAwsVKkcECDYFBk8RAggPEg8sQ?=
 =?us-ascii?q?w5CNzQTBoEGCw4RA09CGWwEggcKU5lqcoEOgyaSMY5ogTRmn2SEBKBgGjKpP?=
 =?us-ascii?q?AGSJIU8o0OERw2BeIIAMxoIJgqDIlIZD44gDBaIKYtBVDsCBwsBAQMJi0MBA?=
 =?us-ascii?q?Q?=
IronPort-Data: A9a23:oFV6t6NIIMfXsvbvrR0xlcFynXyQoLVcMsEvi/4bfWQNrUohgmcHm
 mUZWGHXM66NY2ahe49+Ydi19x4OuZbVmtFmQQZtpSBmQlt08seUXt7xwmUcn8+xwmwvaGo9s
 q3yv/GddKjYdpJfz/uUGuCJQUNUjMlkfZKhTr+UUsxNbVU8Enx50ko+w7RRbrNA2LBVPSvc4
 bsenOWCYDdJ6xYsWo7Dw/nbwP/HlK2aVAIw5jTSV9gS1LPtvyN94KYkGE2EByCQrr+4vgKNb
 72rILmRpgs19vq2Yz+vuu6TnkYiGtY+MeUS45b/tmfLbhVq/0QPPqgH2PU0SE4LlBWys41Lw
 9Bf6YaMSxc0Lu7lsbFIO/VYO3kW0axu47TdJn+wvIqXwkvcfniqxfhyZK00FdNJvL8pXCcUr
 6BecmhWBvyAr7veLLaTVu1rrsAuKtPmP8UZt20IITTxV6l8EcyZE/6iCdlw/DIh2IcJNsTiZ
 9sVYwd9VynESD5iJQJCYH45tKLy7pXlSBVFtFOR4K425XXD5BJ+3aKrM9fPfNGOA8JPkS6lS
 nnuoTW8W09HcYbFlX/fqinqivTL2z/2W5kbCqOpsPVthTV/21AuNfHfbnPjydHRt6J0c4s3x
 5A8ksb2kZUPyQ==
IronPort-HdrOrdr: A9a23:MV3oFa9nORKtcd0gt5Juk+DJI+orL9Y04lQ7vn2ZLiYlF/Bw9v
 re/sjzsCWetN9/YhwdcLy7VJVoIkmslqKdg7NxAV7KZmCP0ldAR7sN0WKN+VLd8lXFltJg6Q
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,236,1673931600"; 
   d="scan'208";a="27284283"
Received: from 69-165-224-203.dsl.teksavvy.com (HELO scrooge.lenrek.net) ([69.165.224.203])
  by smtp12.teksavvy.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2023 18:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lenrek.net;
        s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Bai565oSeC/1Pbu4H6D4TYTkN4Z5aoiMadur4368ntQ=; b=K3vJo9G9s4FAsAQGhCVUPx2zI2
        UMXm4hMqArS6s72T7qwsk9bsAj8LOIoWix7AO7DPD7WPS6wyDqAPKYEQwd1WbyVaupxiaqlwblJPA
        pqriLbduGW46PsHIhg4YIK0DCkCLXj+uiNO3jYUMBp3sLleAGF5mzIuFRd5y46oswwRwPSqyU8t1y
        mLrjQ0BEd/+IYrHBOZgxDsN6uqRdVhvLQ3OquQTnsrLV2cFjqFMXe4e07kX5KCGjYCVo4twbKo/RF
        y+0sZIeDCCdaYdcWXIbXA2FQSSgy+fXLtzKJ9VXFOVDPJJi4VP6HZvbZWF1DEmnEVjA+h0FrdD+eW
        l64nSPeQ==;
Received: from [fd58:b7ab:a802:40:dabb:c1ff:fece:dabe] (helo=marley.lenrek.net)
        by scrooge.lenrek.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <tlo@lenrek.net>)
        id 1pYyFA-0004Mw-0E
        for util-linux@vger.kernel.org;
        Sun, 05 Mar 2023 15:58:20 -0800
Date:   Sun, 5 Mar 2023 15:57:55 -0800
From:   Toomas Losin <tlo@lenrek.net>
To:     util-linux@vger.kernel.org
Subject: [PATCH] libfdisk: Fix randomly generated GPT UUID's
Message-ID: <20230305155755.49a0534e@marley.lenrek.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Fdisk commands that create random GPT UUID's result in values that are
not UEFI-compliant being written to disk: The "g" command creates a
new GPT whose in-core DiskGUID value is entirely big-endian; the "n"
command creates a GPT partition whose in-core UniquePartitionGUID
value is entirely big-endian.  Those big-endian values are written to
disk by the "w" command rather than the mix of little- and big-endian
spec'd by UEFI.

This was caused by a libfdisk patch in 2017 that was addressing
warnings about "taking address of packed member".  Reading gpt.c finds
two instances of dead code which suggests that perhaps there was some
confusion between a struct and a pointer to a struct.  The intent must
have been to convert the randomly generated big-endian RFC 4122 UUID
values to UEFI's mixed-endian but the confusion(?) resulted in some
dead code and non-conversion of the UUID's.

This patch corrects the breakage while still avoiding "taking address
of packed member" warnings.  The "w" command will once again write
UEFI-compliant values to disk.

Fixes: 92e486f80ef8 ("libfdisk: fix guid usage of packed struct gpt_entry")
Signed-off-by: Toomas Losin <tlo@lenrek.net>
---
 libfdisk/src/gpt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index d7b3e1c70..c3c0347cb 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -878,9 +878,9 @@ static int gpt_mknew_header(struct fdisk_context *cxt,
 	if (!has_id) {
 		struct gpt_guid guid;
 
-		uuid_generate_random((unsigned char *) &header->disk_guid);
-		guid = header->disk_guid;
+		uuid_generate_random((unsigned char *) &guid);
 		swap_efi_guid(&guid);
+		header->disk_guid = guid;
 	}
 	return 0;
 }
@@ -2621,9 +2621,9 @@ static int gpt_add_partition(
 		 */
 		struct gpt_guid guid;
 
-		uuid_generate_random((unsigned char *) &e->partition_guid);
-		guid = e->partition_guid;
+		uuid_generate_random((unsigned char *) &guid);
 		swap_efi_guid(&guid);
+		e->partition_guid = guid;
 	}
 
 	if (pa && pa->name && *pa->name)
-- 
2.30.2

