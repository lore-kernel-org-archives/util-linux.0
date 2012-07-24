Return-Path: util-linux-owner@vger.kernel.org
Received: from mx01.sz.bfs.de ([194.94.69.103]:30766 "EHLO mx01.sz.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743Ab2GXO3y (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 10:29:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx01.sz.bfs.de (Postfix) with ESMTP id D313D4AF9B
	for <util-linux@vger.kernel.org>; Tue, 24 Jul 2012 16:29:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mx01.sz.bfs.de (Postfix) with ESMTP id C51A34AFAC
	for <util-linux@vger.kernel.org>; Tue, 24 Jul 2012 16:29:53 +0200 (CEST)
Received: from mx01.sz.bfs.de ([127.0.0.1])
	by localhost (dc-slave-mx01.bfs.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DK+HjmGJePbN for <util-linux@vger.kernel.org>;
	Tue, 24 Jul 2012 16:29:53 +0200 (CEST)
Received: from dc-slave2-fr.fr.bfs.de (dc-slave2-fr.fr.bfs.de [10.177.18.200])
	by mx01.sz.bfs.de (Postfix) with ESMTP id 860EB4AF9B
	for <util-linux@vger.kernel.org>; Tue, 24 Jul 2012 16:29:53 +0200 (CEST)
Received: from [134.92.181.33] (unknown [134.92.181.33])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTPSA id A7D5271CDC4
	for <util-linux@vger.kernel.org>; Tue, 24 Jul 2012 16:29:52 +0200 (CEST)
Message-ID: <500EB160.2020504@bfs.de>
Date: Tue, 24 Jul 2012 16:29:52 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: bug: util-linux-2.21.2 col
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

hi list,
i run into a problem while processing a latin1 file:
col: Invalid or incomplete multibyte or wide character

./col -p -b -l0 <out.asc

out.asc:
^H^H^H^H|DATUM  :    2008-05-07
^H^H^H^H| Schlüssel

the problem occurs at ü (note: clipping may have changed latin1->utf8).

i guess the error occurs here:
               if ((ch = getwchar()) == WEOF) {
                        if (errno == EILSEQ) {
                                warn(NULL);
                                ret = EXIT_FAILURE;
                        }
                        break;

re,
 wh

note: i am not member of the ml
