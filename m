Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655D7EB64DD
	for <util-linux@archiver.kernel.org>; Mon, 31 Jul 2023 00:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGaAOy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 30 Jul 2023 20:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGaAOx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 30 Jul 2023 20:14:53 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Jul 2023 17:14:48 PDT
Received: from smtp-out1-03.simnet.is (smtp-out1-03.simnet.is [194.105.232.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D56E1
        for <util-linux@vger.kernel.org>; Sun, 30 Jul 2023 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1690762489; x=1722298489;
  h=date:from:to:subject:message-id:mime-version;
  bh=LsxnifKvCCNSgPjywC274+U939McPx5FujLzg/87XfY=;
  b=K82JKxKrOS2p5LoPSMNvnxUHBxoqyv3OFIJEFHrgI9bohQutAT4iLjkf
   6qy6DmgXDH2jO3y2YF0cLhmE52QsqkPpvLs5C+7YjCpOY/8e1G1kSC1pT
   iH3owOqWbyFZ25y3Wpgo1WloziRDp+b9w/RBPtGuoi/K/R68cWiLtTGgO
   Cx4VpeQ0D92rAyRQ0xkhHLly6THtEgQEb8JJsIxKALatFYCdtZaSg6rit
   FxZpeSWIDmWuHxYjLxu99z5/XCq1mXU/mdnW0BcSgEg9WKPiHFHyNMl1u
   ldYi3AN4A+yuoAEToBFlQ61br2+paULea8KBjElKivW175ZnQYLF0o3oG
   Q==;
Authentication-Results: smtp-out-03.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 4.4
X-IPAS-Result: =?us-ascii?q?A2FLBABf+sZkkFfoacJagQmBT4IzmDwlHYMpglCYAYINA?=
 =?us-ascii?q?QEBD0QEAQGLTCc2Bw4BAgQBAQEBAwIDAQEBAQEBAwEBBgEBAQEBAQYGAhABA?=
 =?us-ascii?q?QEBAQEgHg4QJ4UvRoY8E4Ewg16CXa0TgQEzgQGzJ4FogUKIAAGKMwaCDYoPh?=
 =?us-ascii?q?VMiBIoDhVAHgUkMCYpJK4EICF+Bbz0CDVQLC2OBGIJJAgIROhQ+EnMbAwcDg?=
 =?us-ascii?q?QUQLwcELyQGCRgvJQZRBQItJAkTFUAEDYNDCoEFPxUOEYJQYTgbTIJqCRUMN?=
 =?us-ascii?q?VB6EC4EFBiBFHghGh49ERIFFg0FCIEBAxoDBgIJAgIEBgkCJkMDBQMEMgNEH?=
 =?us-ascii?q?UADez01FBsGojYqAYEDHFcVC3vEPoQVoWGXAgySOZgooxuFJYFBKQOCDCwHG?=
 =?us-ascii?q?ggwgyNRGQ+iDYExAgcLAQEDCYtIAQE?=
IronPort-PHdr: A9a23:QrmrAh+Sulq/5P9uWA7oyV9kXcBGk67xIhZQ7Yc7zuoVNL+i+pLvI
 Are/qYlgFzIWNDd7PRJw6rTvrv7UGMNqZCGrDgZcZNKWhNEwcUblgAtGoiEXEv8KvOCUg==
IronPort-Data: A9a23:M4IgJKIWxDELK3v6FE+R7ZUlxSXFcZb7ZxGr2PjKsXjdYENShDwDy
 jQWDGDTa6qIZ2bwKNslYYTg8UgAv8OAyIMySVEd+CA2RRqmi+KcXo3BcR2Y0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+lH3dOCJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYx6TSCK13L4
 YqaT/H3Ygf/gGYraTpMscpvlTs21BjMkGJJ1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE88jmSH
 rurIBmRpws1zj91Yj+Xuu+Tnn4iHtY+CTOzZk9+AMBOtPTtShsaic7XPNJEAateZq7gc9pZk
 L2hvrToIesl0zGldE3wnHC0HgknVZCq9oMrLlCvoJawlE/9UUKz4M1AJhprDaYS/7l4VDQmG
 fwwcFjhbzidhvmqhaC6T/F2gdQyaZGyep0eoW0mzCqx4fQOGMGfBfySuJkCh2121p8m8fX2P
 qL1bRJlbRLPYhJOIX8MCZc4kfvuh2KXnzhw+A7F+fVvvzKNpOB3+Ji2COD4R5uOftkPkkCh9
 jzc4G7hKzhPYbRzzhLeriL92b6T9c/hY6oPCLy8s/prhkCD7nIcBQdQVlahp/S9zEmkVLpix
 1c85Cs1se0g9UmzVN7tTljg+TiavwUAHdtLewEn1O2T4rrFuSXCBFMmd2FiUPIM75IGbjYvi
 VDcyrsFGgdTmLGSTHuc8JKdojWzJTUZIAc+icksEVptDz7L/NBbs/7fcjpwOPDo0I2vR1kc1
 xjP9Xhm2ORM5SIe///jpTj6bySQSo/hbzVdCu//d2G49A5ofo/Ni2eAtwCDhRqsBKCeVEWBs
 XEfh6CjAA0mE5CWiGmfQeAVBra59rPdaXvCgEVzWZg6n9hMx5JBVd4JiN2dDB0wWirhRdMPS
 BSK0e+2zMUCVEZGlYctP+qM5z0ClMAM7+jNWPHOdcZpaZNsbgKB9ywGTRfOjjiyzBF8yvxjY
 srznSOQ4ZAyVfUPIN2eG7Z17FPX7nFWKZ77HMqglEX9uVZgTCDNEd/pz2dinshisPPV/1SJm
 zquH86LzxwXUOOWX8Uk2dN7ELz+FlBiXcqeg5UOKoarfFE8cEl/UKC5/F/UU9A590ijvrySp
 SDVt44x4AaXuEAr3i3WMys+N+2yAsklxZ/5VAR1VWuVN7EYSd7HxM8im1EfJNHLKMQLISZIc
 sQ4
IronPort-HdrOrdr: A9a23:FCf0oKn4pm8b7oOsVv+eHSJU1UvpDfIz3DAbv31ZSRFFG/Fws/
 re+sjztCWE7wr5N0tApTntAsm9qBDnhPpICOsqTNKftWDd0QPCRuwPguXfKlbbak/DH4BmpM
 RdT5Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A0uL35GmrhuJor57yq8h/oaIyQhHXOW3MllSLIXS?=
 =?us-ascii?q?aMDlKcJO/EgKg06lhzMU7zg=3D=3D?=
X-Talos-MUID: 9a23:HvyJRgml5cy+odOFqSo9dnpCb/9SzpnpDHsRy5kAgpnaLzN6Ix602WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,243,1684800000"; 
   d="scan'208,223";a="848470426"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-03.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 00:13:42 +0000
Received: from localhost (localhost [127.0.0.1])
        by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 0DE28408C53D
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2023 00:13:41 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
        by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XcVuGRYtHoB6 for <util-linux@vger.kernel.org>;
        Mon, 31 Jul 2023 00:13:40 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by vist-zimproxy-01.vist.is (Postfix) with ESMTP id ABC6D408C540
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2023 00:13:40 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
        by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 43AazWumsUl1 for <util-linux@vger.kernel.org>;
        Mon, 31 Jul 2023 00:13:40 +0000 (GMT)
Received: from kassi.invalid.is.lan (85-220-7-150.dsl.dynamic.simnet.is [85.220.7.150])
        by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id 9547A408C53D
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2023 00:13:40 +0000 (GMT)
Received: from bg by kassi.invalid.is.lan with local (Exim 4.96)
        (envelope-from <bingigis@simnet.is>)
        id 1qQGXb-0001a1-00
        for util-linux@vger.kernel.org;
        Mon, 31 Jul 2023 00:13:39 +0000
Date:   Mon, 31 Jul 2023 00:13:38 +0000
From:   Bjarni Ingi Gislason <bjarniig@simnet.is>
To:     util-linux@vger.kernel.org
Subject: documents (andoc files), spelling mistakes
Message-ID: <ZMb8snehCDMT4tS6@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  From "codespell"

./misc-utils/uuidd.8.adoc:28: gurantees ==> guarantees

-.-.

./term-utils/scriptlive.1.andoc:

*Be careful!* Do not forget that the typescript may contains arbitrary
commands. It is recommended to use *"scriptreplay --stream in --log-in
typescript"* (or with *--log-io* instead of *--log-in*) to verify the
typescript before it is executed by *scriptlive*.

contains -> contain

-.-.

  The distance between sentences is hardcoded in the sources.

-.-.

  Separate the sentences and subordinate clauses;
each begins on a new line.
See man-pages(7) ("Conventions for source file layout") and "info
groff" ("Input Conventions").

  The best procedure is to always start a new sentence on a new line,
at least, if you are typing on a computer.

Remember coding: Only one command ("sentence") on each (logical) line.

E-mail: Easier to quote exactly the relevant lines.

Generally: Easier to edit the sentence.

Patches: Less unaffected text.

Search for two adjacent words is easier,
when they belong to the same line,
and the same phrase.

  Man pages (with groff, man (man-db)):

  The amount of space between sentences in the output can then be
controlled with the ".ss" request.
