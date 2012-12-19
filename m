Return-Path: util-linux-owner@vger.kernel.org
Received: from tha.ppgk.com.pl ([77.252.116.179]:31217 "EHLO tha.ppgk.com.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755535Ab2LSP6H (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Dec 2012 10:58:07 -0500
Received: from localhost.ppgk.com.pl (localhost [127.0.0.1])
	by tha.ppgk.com.pl (Postfix) with ESMTP id CC738375F8
	for <util-linux@vger.kernel.org>; Wed, 19 Dec 2012 16:50:40 +0100 (CET)
Received: from tha.ppgk.com.pl ([127.0.0.1])
	by localhost.ppgk.com.pl (tha.ppgk.com.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VBAmJFo3XaoD for <util-linux@vger.kernel.org>;
	Wed, 19 Dec 2012 16:50:40 +0100 (CET)
Received: from [192.168.100.249] (shodan.ppgk.com.pl [192.168.100.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by tha.ppgk.com.pl (Postfix) with ESMTPSA id 6213C375F6
	for <util-linux@vger.kernel.org>; Wed, 19 Dec 2012 16:50:40 +0100 (CET)
Message-ID: <50D1E252.5070805@ziu.info>
Date: Wed, 19 Dec 2012 16:50:42 +0100
From: Michal Soltys <soltys@ziu.info>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: hwclock recent commits - question
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Namely regarding commit:

839be2ba6b44fa9dc927f081d547ebadec9de19c

and subsequent Tom's fix:

910a090039cbd529041bfb5f6be72bf27a96bd47


 From what I can see, the "old" and current hwclock's behaviour is 
actually identical, with exception of relying on either warp_clock() 
call (current version, one-shot only) or do_settimeofday() (previous 
version, consistent on each call).

Was the switch to warp_clock() the main reason after the change, or were 
there other issues with standard approach ?

