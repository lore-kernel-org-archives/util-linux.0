Return-Path: <SRS0=l+by=AU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA08CC433E1
	for <util-linux@archiver.kernel.org>; Thu,  9 Jul 2020 23:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD9320578
	for <util-linux@archiver.kernel.org>; Thu,  9 Jul 2020 23:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIXXV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXXV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Jul 2020 19:23:21 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD75C08C5CE
        for <util-linux@vger.kernel.org>; Thu,  9 Jul 2020 16:23:20 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 069NNFHQ028670
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Thu, 9 Jul 2020 23:23:16 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 069NNFHQ028670
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 069NNFvk028462
        for <util-linux@vger.kernel.org>; Thu, 9 Jul 2020 23:23:15 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 069NNFCT028461
        for util-linux@vger.kernel.org; Thu, 9 Jul 2020 23:23:15 GMT
Date:   Thu, 9 Jul 2020 23:23:15 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: docs: mount.8: What does "with in libmount" mean
Message-ID: <20200709232315.GA28427@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Line 2556 in "sys-util/mount.8":

filesystem is mounted.  Requires libcryptsetup with in libmount
(optionally via dlopen).
                                               *******

-- 
Bjarni I. Gislason
