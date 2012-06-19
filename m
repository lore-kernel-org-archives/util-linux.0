Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38874 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab2FSLo1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Jun 2012 07:44:27 -0400
Received: by wibhm6 with SMTP id hm6so2556378wib.1
        for <util-linux@vger.kernel.org>; Tue, 19 Jun 2012 04:44:26 -0700 (PDT)
From: Marek Otahal <markotahal@gmail.com>
To: util-linux@vger.kernel.org
Subject: dev.c : Warning - dereference of null pointer, clang --analyze
Date: Tue, 19 Jun 2012 13:44:12 +0200
Message-ID: <1468557.if6BRfJlxj@beruska>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi list, 
I was just building util-linux with clang to see how it's static code analysis works. 
Here's what I got so far, I'm not sure about it's correctness, so excuse me if it's stupid. 

 CC       dev.lo
clang: warning: unknown warning option '-Wmissing-parameter-type'; did you mean '-Wmissing-prototypes'?
clang: warning: unknown warning option '-Wunused-but-set-parameter'; did you mean '-Wunused-parameter'?
clang: warning: unknown warning option '-Wunused-but-set-variable'; did you mean '-Wunused-variable'?
dev.c:91:16: warning: Access to field 'next' results in a dereference of a null pointer
      (loaded from variable 'p')
        list_for_each(p, &dev->bid_tags) {
        ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
../../include/list.h:179:48: note: expanded from macro 'list_for_each'
        for (pos = (head)->next; pos != (head); pos = pos->next)
                                                      ^
1 warning generated.

Best regards, Mark 
-- 

Marek Otahal :o)
