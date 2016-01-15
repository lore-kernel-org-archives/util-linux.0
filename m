Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33727 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcAOCgp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Jan 2016 21:36:45 -0500
Received: by mail-qg0-f44.google.com with SMTP id b35so368764938qge.0
        for <util-linux@vger.kernel.org>; Thu, 14 Jan 2016 18:36:44 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 14 Jan 2016 21:36:44 -0500
Message-ID: <CAP0dga9EC649Wv04qSgythX2t+yO8gg=6TH80K6dBY4D1yUgCg@mail.gmail.com>
Subject: How to obtain the manual of util-linux?
From: flylehe <flylehe@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Does util-linux have a manual, similar to coreutils' official manual
https://www.gnu.org/software/coreutils/manual/ ?

I downloaded the source distribution of util-linux-2.27, and tried to
create the documentation by

./configure
make install-pdf
make pdf
make pdf-recursive
make install-html

but either "Nothing to be done" or " No rule to make target".
Did I miss something?

Thanks.
