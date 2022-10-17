Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89B9C4332F
	for <util-linux@archiver.kernel.org>; Mon, 17 Oct 2022 10:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJQKKS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Oct 2022 06:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiJQKKP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 17 Oct 2022 06:10:15 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D744662C
        for <util-linux@vger.kernel.org>; Mon, 17 Oct 2022 03:10:12 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thomasvoss.com;
        s=key1; t=1666001411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GGMQNTFQOW/TiVwbNPBXirDkqP4wPdCWT9yTDcbcMU=;
        b=q3Y208xSUGvdtt0+GyMmyxM2EBuoUwYaE0Awmque+mnb0VPp212v/KgsrgtZfeg8u/23D4
        wXUOxl4huOeFqR9Hu1GYdZrIJDvZuFF1FY8uDazJ+gkUl9z7yy9srDuI0+9NQPemMuAYpQ
        fYOB18F1Ti6smAzz2/4tKezkwtE2jqh9dUjKdeZmCIahzYbL3RopNR2c73EK90+HOFdQYm
        vyQO8Dz/rcgNP+RkNA8NswvkzWg/9jF4f1XXYgn0qVyyx5BDY0gThcffbGEdI/Xs5rp+nt
        Q0zBFfVp8hwVN2ExRa06bqPVvHrcx/4DWnKlZZmcA8Kx7KS6o0R51gjR9WslTQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Oct 2022 12:10:19 +0200
Message-Id: <CNO47QIM62X8.1T7V20XJ1ESE3@mango-os>
Cc:     "util-linux" <util-linux@vger.kernel.org>
Subject: Re: Proposal for new column(1) flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Thomas Voss" <mail@thomasvoss.com>
To:     "Karel Zak" <kzak@redhat.com>
References: <CNL1J5PPBA9T.2ZR8EL0OSX1XJ@mango-os>
 <20221017084247.egoe7ljueklp5jvb@ws.net.home>
In-Reply-To: <20221017084247.egoe7ljueklp5jvb@ws.net.home>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon Oct 17, 2022 at 10:42 AM CEST, Karel Zak wrote:
> I guess you want "table" mode for the column (see --table-* options).
> It provides almost all features from libsmartcols. The next important
> thing for your use-case is --output-separator, for example
>
>   $ echo "AAA BBB CCC" | ./column -t --output-separator "..."
>   AAA...BBB...CCC
>
> of course you can use "   " to define space as separator, etc.

That doesn't quite work as a solution the moment that any item I want to
display in a column contains spaces though.

- Thomas
