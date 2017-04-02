Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.netzguerilla.net ([217.11.57.120]:55831 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdDBS4Q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 2 Apr 2017 14:56:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 904CC100013
        for <util-linux@vger.kernel.org>; Sun,  2 Apr 2017 20:56:14 +0200 (CEST)
Received: from mail.netzguerilla.net ([IPv6:2a00:1828:2000:612::25])
        by localhost (sal.netzguerilla.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id jC_TI_-RUjk3 for <util-linux@vger.kernel.org>;
        Sun,  2 Apr 2017 20:56:12 +0200 (CEST)
Received: from [192.168.1.103] (unknown [46.78.109.228])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id 44B3F100012
        for <util-linux@vger.kernel.org>; Sun,  2 Apr 2017 20:56:12 +0200 (CEST)
References: <58CAA79B.4010108@projektwerkstatt.de>
Subject: not responding
To: util-linux@vger.kernel.org
From: kalle <kalle@projektwerkstatt.de>
Message-ID: <95b803a1-8288-25d6-4bbe-738348016813@projektwerkstatt.de>
Date: Sun, 2 Apr 2017 20:56:07 +0200
MIME-Version: 1.0
In-Reply-To: <58CAA79B.4010108@projektwerkstatt.de>
Content-Type: multipart/mixed;
 boundary="------------A299B0EBEFA5FEB13810D571"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------A299B0EBEFA5FEB13810D571
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

hello,
on 16.03.17 I wrote you the following e-mail without getting any response:

--------------A299B0EBEFA5FEB13810D571
Content-Type: message/rfc822;
 name="\"more\".eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="\"more\".eml"

From: kalle <kalle@projektwerkstatt.de>
Subject: "more"
To: util-linux@vger.kernel.org
X-Enigmail-Draft-Status: N1110
Message-ID: <58CAA79B.4010108@projektwerkstatt.de>
Date: Thu, 16 Mar 2017 15:56:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

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

--------------A299B0EBEFA5FEB13810D571--
