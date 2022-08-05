Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8978C25B08
	for <util-linux@archiver.kernel.org>; Fri,  5 Aug 2022 15:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbiHEP5j (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 5 Aug 2022 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbiHEPz5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 5 Aug 2022 11:55:57 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 08:55:55 PDT
Received: from toro.web-alm.net (toro.web-alm.net [62.245.132.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0AF91C2
        for <util-linux@vger.kernel.org>; Fri,  5 Aug 2022 08:55:55 -0700 (PDT)
Received: from toro.web-alm.net (localhost.localdomain [127.0.0.1])
        by toro.web-alm.net (8.12.11.20060308/8.12.11/Web-Alm-2003112001) with ESMTP id 275Fo8cn018443
        for <util-linux@vger.kernel.org>; Fri, 5 Aug 2022 17:50:08 +0200
Received: from rack3slot8.osadl.org (uucp@localhost)
        by toro.web-alm.net (8.12.11.20060308/8.12.10/Submit/Web-Alm-2003112001) with bsmtp id 275Fo8o3018441
        for util-linux@vger.kernel.org; Fri, 5 Aug 2022 17:50:08 +0200
Received: from rack0slot7.osadl.org (rack3slot8.osadl.org [127.0.0.1])
        by rack3slot8.osadl.org (8.13.8/8.13.8/CE-2010120801) with ESMTP id 275FmwOp023829
        for <util-linux@vger.kernel.org>; Fri, 5 Aug 2022 17:48:59 +0200
Received: (from root@localhost)
        by rack0slot7.osadl.org (8.17.1/8.17.1/Submit) id 275FmwjO2272717
        for util-linux@vger.kernel.org; Fri, 5 Aug 2022 17:48:58 +0200
Message-ID: <20220805154820.407972387@osadl.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Aug 2022 17:48:20 +0200
From:   Carsten Emde <C.Emde@osadl.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH 0/1] Taskset: check first whether affinity is settable 
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on rack3slot8.osadl.org
X-Virus-Status: Clean
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If the PF_NO_SETAFFINITY process flag is set, the user may not
know why the affinity is not settable. Write a respective message
and do not attempt to set the affinity of this process.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
