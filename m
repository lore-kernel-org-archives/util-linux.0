Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.netzguerilla.net ([217.11.57.120]:57979 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbdCPPWP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 16 Mar 2017 11:22:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 0BF2210001A
        for <util-linux@vger.kernel.org>; Thu, 16 Mar 2017 15:56:30 +0100 (CET)
Received: from mail.netzguerilla.net ([IPv6:2a00:1828:2000:612::25])
        by localhost (sal.netzguerilla.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id B67xWutBxxux for <util-linux@vger.kernel.org>;
        Thu, 16 Mar 2017 15:56:28 +0100 (CET)
Received: from [192.168.1.105] (unknown [2.171.217.220])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id 89C73100017
        for <util-linux@vger.kernel.org>; Thu, 16 Mar 2017 15:56:28 +0100 (CET)
From: kalle <kalle@projektwerkstatt.de>
Subject: "more"
To: util-linux@vger.kernel.org
Message-ID: <58CAA79B.4010108@projektwerkstatt.de>
Date: Thu, 16 Mar 2017 15:56:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

hello.
i have util-linux version 2.20.1 , the "more"-manpage says version 5.19
of more, and found the following problems in "more":
I start with more FILE.
then "=" to get the line "57". It is to say here, that the first line of
the screen, will not be shown again, even if typing "b".
Then z ;then = again. Gives line 115.
b;= :line 58
s;= :line 116
b;= :line 59
f;= :line 173
b;= :line 116
b;= :line 59

This result seems to contradict to man more's definitions of
-"s" :"skip forward k lines of text. Defaults to 1."
-"f" :"skip forward k screenfuls of text. Defaults to 1."
