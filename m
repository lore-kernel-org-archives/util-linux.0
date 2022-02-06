Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500BBC433F5
	for <util-linux@archiver.kernel.org>; Sun,  6 Feb 2022 06:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiBFGMW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 6 Feb 2022 01:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBFGMV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 6 Feb 2022 01:12:21 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D090C06173B
        for <util-linux@vger.kernel.org>; Sat,  5 Feb 2022 22:12:20 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u18so22532018edt.6
        for <util-linux@vger.kernel.org>; Sat, 05 Feb 2022 22:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npcs/EIJggKDsKeAtCQYFepca818j2DVfHt5Xr/yQMI=;
        b=OvkRDqnAjPTcU3yoh0zwh1ysnzXOoBkZrAsgNUTM2SQoVghhvyAUSDgViI7CUsd3WI
         Hwo3z0vsUw1794vvxOiiWN2ZdSjSNxx1oihTQ+lzDUk/yiR9Q6ONx6zx+TuruH9m5aPr
         lLlEO4ApFAmDu10smOtYrfREecmOKFatIEx6LpYZd9ap+Ztdile1nODSkgAilpjBFi+g
         aAeWN96g98bNC0q+LdgaOeYbD0QONfjrb9TC8ZGCO6ucDAcgI07LeYbBdc4mpH93D/zZ
         FiNClGuMMni0PHeHVBFDvtU9WrtrB29JweL3Xt8Prp52GJZJ+c2nsPC+nJBgDF9e0tx+
         vROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npcs/EIJggKDsKeAtCQYFepca818j2DVfHt5Xr/yQMI=;
        b=eTbfHcZSjDUdcIasPor3MPNl6DRHxT5tSudjaOe5IsitPcZcgbbYaTezZyakIKvXhj
         sofxjIQXIoaPmzW95y/fAYP6e/ZVPxtopHgjfhAJxjGnSrJr1Li1Y+cAdr/nbr2rccwB
         WlLNKW51ScoOr9p8WB+TTZB03Th/MCHuPZ7tYxPM2iCF+enyId4xpeXHBvzQ72UKVaTH
         7BUs2f8ZxlQgOiDax1MfQ9OeMddXM4cRMNZ9hay6UNseA/Ru3g7hwGHYp/ChIT8iLRAa
         wkMFbxZVZLdQVGsaQUyrSI9iOvA5WuJ4NRSSyVzyLeOb4MJFw10ITdHMJhRe2jYKY6Dy
         Wj/w==
X-Gm-Message-State: AOAM532u6hOOHLDTkom9ev8A35CWZlpE5V0KZbcPdv144/VfNFVFVeZc
        IWXE38aNpWRJcW/slRM6GjyEvs9Nezc=
X-Google-Smtp-Source: ABdhPJxaycqCS1uni7b3zBz5a7MJConJXYWlroaaTXSa3EGDuy/hW9AohlgMF6iLZtGG+/ZgaUQ71A==
X-Received: by 2002:a05:6402:5188:: with SMTP id q8mr7306362edd.173.1644127938925;
        Sat, 05 Feb 2022 22:12:18 -0800 (PST)
Received: from localhost.localdomain (178.115.71.30.wireless.dyn.drei.com. [178.115.71.30])
        by smtp.gmail.com with ESMTPSA id bv2sm2264420ejb.154.2022.02.05.22.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 22:12:18 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH 4/4] getopt.1.adoc: render synopsis rules on separate lines
Date:   Sun,  6 Feb 2022 07:11:58 +0100
Message-Id: <20220206061158.752262-4-aclopte@gmail.com>
X-Mailer: git-send-email 2.35.1.301.gcdacdcff8b.dirty
In-Reply-To: <20220206061158.752262-1-aclopte@gmail.com>
References: <20220206061158.752262-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

AsciiDoc ignores single line breaks, so the synopsis of

	*getopt* _variant1_
	*getopt* _variant2_

will render as one line in the manpage.

Fix this by adding a blank line in between two rules, like we do
elsewhere.  This means that the manpage also has blank lines.

	*getopt* _variant1_

	*getopt* _variant2_

Alternative solution: we could avoid the blank lines like below,
but that'd be inconsistent with our other manpages.

	*getopt* _variant1_ +
	*getopt* _variant2_ +

or, equivalently, use the verse[*] directive

	[verse]
	*getopt* _variant1_
	*getopt* _variant2_

[*]: https://docs.asciidoctor.org/asciidoc/latest/blocks/verses/

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 misc-utils/getopt.1.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc-utils/getopt.1.adoc b/misc-utils/getopt.1.adoc
index 6cbdd5174..7a80b141e 100644
--- a/misc-utils/getopt.1.adoc
+++ b/misc-utils/getopt.1.adoc
@@ -14,7 +14,9 @@ getopt - parse command options (enhanced)
 == SYNOPSIS
 
 *getopt* _optstring_ _parameters_
+
 *getopt* [options] [*--*] _optstring_ _parameters_
+
 *getopt* [options] *-o*|*--options* _optstring_ [options] [*--*] _parameters_
 
 == DESCRIPTION
-- 
2.35.1.301.gcdacdcff8b.dirty

