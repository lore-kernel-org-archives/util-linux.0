Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F734C19F2D
	for <util-linux@archiver.kernel.org>; Sat,  6 Aug 2022 23:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiHFXDM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 6 Aug 2022 19:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiHFXDL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 6 Aug 2022 19:03:11 -0400
Received: from toro.web-alm.net (toro.web-alm.net [62.245.132.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74E1B10548
        for <util-linux@vger.kernel.org>; Sat,  6 Aug 2022 16:03:09 -0700 (PDT)
Received: from toro.web-alm.net (localhost.localdomain [127.0.0.1])
        by toro.web-alm.net (8.12.11.20060308/8.12.11/Web-Alm-2003112001) with ESMTP id 276N38CW023125
        for <util-linux@vger.kernel.org>; Sun, 7 Aug 2022 01:03:08 +0200
Received: from rack3slot8.osadl.org (uucp@localhost)
        by toro.web-alm.net (8.12.11.20060308/8.12.10/Submit/Web-Alm-2003112001) with bsmtp id 276N38Xc023123
        for util-linux@vger.kernel.org; Sun, 7 Aug 2022 01:03:08 +0200
Received: from rack0slot7.osadl.org (rack3slot8.osadl.org [127.0.0.1])
        by rack3slot8.osadl.org (8.13.8/8.13.8/CE-2010120801) with ESMTP id 276MsJh5014573
        for <util-linux@vger.kernel.org>; Sun, 7 Aug 2022 00:54:19 +0200
Received: (from root@localhost)
        by rack0slot7.osadl.org (8.17.1/8.17.1/Submit) id 276MsJjZ3526778
        for util-linux@vger.kernel.org; Sun, 7 Aug 2022 00:54:19 +0200
Message-ID: <20220806224915.326517265@osadl.org>
User-Agent: quilt/0.66
Date:   Sun, 07 Aug 2022 00:49:15 +0200
From:   Carsten Emde <C.Emde@osadl.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH v2 0/1] Taskset: check first whether affinity is settable
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on rack3slot8.osadl.org
X-Virus-Status: Clean
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Sorry, need v2, forgot that task commands may have spaces nowadays.

Current version successfully tested with various commands:
# taskset -p 3fff 3
pid 3's current affinity mask: ffff
warning: affinity cannot be set due to PF_NO_SETAFFINITY flag set
taskset: failed to set pid 3's affinity: Invalid argument

# Command "PCIe PME"
# taskset -p 3fff 191
pid 191's current affinity mask: 8
pid 191's new affinity mask: 3fff

Signed-off-by: Carsten Emde <C.Emde@osadl.org> 
