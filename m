Return-Path: <SRS0=v0ph=QN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4458C169C4
	for <util-linux@archiver.kernel.org>; Wed,  6 Feb 2019 15:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B873A2175B
	for <util-linux@archiver.kernel.org>; Wed,  6 Feb 2019 15:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBFPui (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:50:38 -0500
Received: from mx2.b1-systems.de ([78.46.169.121]:46730 "EHLO
        mx2.b1-systems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfBFPui (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Feb 2019 10:50:38 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 10:50:37 EST
Received: from [192.168.42.128] (p578E00CD.dip0.t-ipconnect.de [87.142.0.205])
        by mx2.b1-systems.de (Postfix) with ESMTPSA id 8631320477
        for <util-linux@vger.kernel.org>; Wed,  6 Feb 2019 15:44:23 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Johannes Unglert <unglert@b1-systems.de>
Subject: Improvement suggestion for mkfs.8 manpage
Openpgp: preference=signencrypt
Autocrypt: addr=unglert@b1-systems.de; keydata=
 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
 uS8hi2qfvOSST0k=
Organization: B1-Systems GmbH
Message-ID: <8cac72fd-8116-53e9-1a7f-5c22377dce04@b1-systems.de>
Date:   Wed, 6 Feb 2019 16:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------10F080FFD60BB1D0DBFBE94F"
Content-Language: en-US
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a multi-part message in MIME format.
--------------10F080FFD60BB1D0DBFBE94F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

i stumbled upon a minor spelling error in the mkfs.8 manpage.
It´s an capitalization error for the verbose option.

Please see attached diff for more information.

How should i handle this? What´s the desired procedure?
Do you want me to create a pull-request?


with best regards

Johannes Unglert
-- 
Johannes Unglert
Auszubildender Fachinformatik - AE
Tel.: +49 1512 2088159
Mail: unglert@b1-systems.de

B1 Systems GmbH
Osterfeldstraße 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt, HRB 3537

--------------10F080FFD60BB1D0DBFBE94F
Content-Type: text/x-patch;
 name="mkfs.8.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="mkfs.8.patch"

*** util-linux/disk-utils/mkfs.8	2019-02-06 16:16:12.585415680 +0100
--- util-linux/disk-utils/mkfs.8.new	2019-02-06 16:16:25.693415630 +0100
***************
*** 43,49 ****
  .I fs-options
  Filesystem-specific options to be passed to the real filesystem builder=
=2E
  .TP
! .BR \-V , " \-\-verbose"
  Produce verbose output, including all filesystem-specific commands
  that are executed.
  Specifying this option more than once inhibits execution of any
--- 43,49 ----
  .I fs-options
  Filesystem-specific options to be passed to the real filesystem builder=
=2E
  .TP
! .BR \-v , " \-\-verbose"
  Produce verbose output, including all filesystem-specific commands
  that are executed.
  Specifying this option more than once inhibits execution of any

--------------10F080FFD60BB1D0DBFBE94F--
