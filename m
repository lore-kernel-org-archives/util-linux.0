Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:58280 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755667AbdCLKZn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Mar 2017 06:25:43 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id v2CAPdDu006849
        for <util-linux@vger.kernel.org>; Sun, 12 Mar 2017 03:25:41 -0700
Message-ID: <58C52223.1000008@tlinx.org>
Date: Sun, 12 Mar 2017 03:25:39 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: missing syms @ link filed as bugzilla.kernel.org#194857
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=194857

Different utils gave different syms -- wasn't just the color
related ones -- but like nothing is linking in files
from the '<proj>/libs' dir...



