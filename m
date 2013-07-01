Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.103]:41435 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab3GAPHN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Jul 2013 11:07:13 -0400
Message-ID: <51D196DC.9070401@zoho.com>
Date: Mon, 01 Jul 2013 16:49:00 +0200
From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Wrong more(1) bash-completion on filenames with spaces
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The bash completion for more(1) treats the space-separated pieces of 
filenames as different files.

$ touch foo\ bar
$ more foo<TAB>
bar foo

Trying to hint the space doesn't help, either:
more foo\<TAB> → more foo\\
more foo\\<TAB> → more foo\\\\
more foo\\ <TAB> → more foo\\\

Workaround: Remove the bash completion and use the default one:
$ chmod a-r /usr/share/bash-completion/completions/more


