Return-Path: util-linux-owner@vger.kernel.org
Received: from dna.y42.org ([176.9.161.194]:9562 "EHLO dna.y42.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754401AbbG0Wua (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Jul 2015 18:50:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dna.y42.org (Postfix) with ESMTP id C8F762615C
	for <util-linux@vger.kernel.org>; Tue, 28 Jul 2015 00:40:50 +0200 (MEST)
Received: from dna.y42.org ([127.0.0.1])
	by localhost (dna.y42.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a2eHlW7-2FCk for <util-linux@vger.kernel.org>;
	Tue, 28 Jul 2015 00:40:50 +0200 (MEST)
Received: from [192.168.2.2] (p5DE95812.dip0.t-ipconnect.de [93.233.88.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: urban@dna.y42.org)
	by dna.y42.org (Postfix) with ESMTPSA
	for <util-linux@vger.kernel.org>; Tue, 28 Jul 2015 00:40:50 +0200 (MEST)
To: util-linux@vger.kernel.org
From: Robert Urban <urban@unix-beratung.de>
Subject: Feature request: write out buffer to typescript on SIGTERM
Message-ID: <55B6B370.5020602@unix-beratung.de>
Date: Tue, 28 Jul 2015 00:40:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

is there a good reason why script does not flush it's typescript buffer when it
gets a signal such as SIGTERM?

cheers,
Rob
