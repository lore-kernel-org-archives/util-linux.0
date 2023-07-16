Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD6EB64DD
	for <util-linux@archiver.kernel.org>; Sun, 16 Jul 2023 17:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjGPRcJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 16 Jul 2023 13:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGPRcI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 16 Jul 2023 13:32:08 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A19A116
        for <util-linux@vger.kernel.org>; Sun, 16 Jul 2023 10:32:07 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1689528723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rFI7SUWWkXzEjd24ByE3/l1yZ9KwddQiCAcEguxo5nM=;
        b=EEOarYlbxnUqjjhNqU6h9VLZzuduWPLUGfGOcG2vPjotwjsvf1AeVUR2j5IG2pHW5MLfYq
        8poPxz2qK5r+vwV6UgCEr/4yjZ1sr4pYojGKhkTRCkVPgC0zI+TyhShwefzl+wsvulJFAn
        qcsCqL/bbUbRE7m+LQ/6Q7o+S4pM4jxmWu/X9bmU/Ifl2POQYKXneX7TT5/+8z3k5n15bp
        MBFigBd5EJswRT735KhiEvgPxd+qU2PYyGYcEEP/6/jgMHIguoxcAaH10JjgtOX9jLzM6+
        RbYXAjHE5tWW7ajWDhCNXAJnrqmkNqg+L34tS+oMQFvB2UjLm6N8NK9cOw0S3Q==
Date:   Sun, 16 Jul 2023 19:32:03 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     util-linux@vger.kernel.org
Subject: [RFC] Alternative color configuration for dmesg
Message-ID: <e6370090700c26776e2ce6444a05a2d2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

I'd like to implement support for an additional, alternative way for the 
color configuration in the dmesg utility.  It would use an environment 
variable to store the color configuration, in a way rather similar to 
what grep(1) does using the GREP_COLORS environment variable.

The rationale behind this new feature is the ability to have everything 
contained in one's ~/.bashrc, for example, with no need for additional 
configuration files, which makes setting up, using and keeping multiple 
machines in sync much easier.  Of course, the current way of using 
configuration files to store the color configuration for dmesg would 
remain untouched, so everyone would be free to make a choice.

Would you, please, accept a patch that implements the above-described 
new feature?
