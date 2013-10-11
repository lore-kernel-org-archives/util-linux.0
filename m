Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp2.hushmail.com ([65.39.178.134]:54780 "EHLO
	smtp2.hushmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486Ab3JKLLU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Oct 2013 07:11:20 -0400
Received: from smtp2.hushmail.com (localhost [127.0.0.1])
	by smtp2.hushmail.com (Postfix) with SMTP id 1F8EBA010C
	for <util-linux@vger.kernel.org>; Fri, 11 Oct 2013 10:34:31 +0000 (UTC)
Received: from smtp.hushmail.com (w4.hushmail.com [65.39.178.50])
	by smtp2.hushmail.com (Postfix) with ESMTP
	for <util-linux@vger.kernel.org>; Fri, 11 Oct 2013 10:34:31 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 11 Oct 2013 12:34:30 +0200
To: util-linux@vger.kernel.org
From: bugreporter99@hushmail.com
Content-Type: text/plain; charset="UTF-8"
Message-Id: <20131011103431.0FBC9C04A6@smtp.hushmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

I'm new to linux and tried to use "lscpu".
After asking around on the ubuntu IRC channel I got told that the first line of the output "Architecture:..." tells the architecture of my OS and NOT my cpu.
Could you please change the text in the first line somehow?
Maybe "Architecture (of operating system):" or os architecture or something in those lines?
Cause when I use lscpu I think (as a newbe) it will list all things about my cpu and not about my operating system.
Thanks!

