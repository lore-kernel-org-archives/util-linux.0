Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD25C433F5
	for <util-linux@archiver.kernel.org>; Sun, 13 Mar 2022 09:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiCMJan (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Mar 2022 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiCMJam (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2022 05:30:42 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90924BE6
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2022 01:29:35 -0800 (PST)
X-KPN-MessageId: 0d372a0a-a2b0-11ec-8338-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 0d372a0a-a2b0-11ec-8338-005056999439;
        Sun, 13 Mar 2022 10:29:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=content-type:subject:from:to:mime-version:date:message-id;
        bh=CjEsd/JoL7JRA5U3p4yQnPUFf69EK+2X4vD1rjX/H68=;
        b=aNEx2s4pjMyF/nUXnPmaZlHG58mYwT3f36d3iJI0X8APls4b+v+nGgDQIOpdzkQVoh1vyEFvk+WVY
         nWvLzNp8tTrVMWObwCavUWGwXjt03MAIleXYQB/Id27j4oGbI115jEB1nmEXulD3AJlL6YrLY99KCT
         bHw0a+jNbnLv5tpY=
X-KPN-MID: 33|aabYR3wXahJFOuuyv6oXQ99t6FpAqUMDL0lOT4f0P4BEVdky0s4TBPZI9CpTSZC
 PYonn4/NONLx65kkUOrkrTc8/0D30AUSXR1f8dLBzTY8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nHJ7uNCZihWSSoVNYTJYVUkZ4EZRALeteUSU3g03mo0Izl9qLf0tzK2ChLtVF34
 1rxyJLCuKZ7qSXJjOjBn0Cw==
X-Originating-IP: 82.168.50.91
Received: from [192.168.2.25] (82-168-50-91.fixed.kpn.net [82.168.50.91])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id 177a4b39-a2b0-11ec-b2a4-005056998788;
        Sun, 13 Mar 2022 10:29:33 +0100 (CET)
Message-ID: <81038e8e-599e-1577-dcb8-30712100fb10@telfort.nl>
Date:   Sun, 13 Mar 2022 10:29:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     util-linux@vger.kernel.org
From:   Benno Schulenberg <bensberg@telfort.nl>
Subject: Re: [PATCH 2/2] hardlink: grammarize the main description in the man
 page
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


Benno Schulenberg wrote:
> (Also hard-wrap the extremely long line to resonable widths,

Let me fix that typo in a V2.

Benno

