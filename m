Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:54239 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbbAEKLs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Jan 2015 05:11:48 -0500
Received: by mail-we0-f173.google.com with SMTP id q58so7566472wes.32
        for <util-linux@vger.kernel.org>; Mon, 05 Jan 2015 02:11:47 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 5 Jan 2015 11:11:47 +0100
Message-ID: <CAO7R9g8opv3Z3aW73xJ-d3ZBwi5_f4td9Xeqk=QBUCqz13fGhw@mail.gmail.com>
Subject: questions on util-linux translation
From: Antonio Ceballos <aceballos@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi util-linux team,

I am the Spanish translator of util-linux, and I would like to ask you
a couple of questions. I am working on the translation of util-linux
2.25.1-rc1.

1. In the following piece of the .pot file:

#: disk-utils/mkfs.c:47
#, c-format
msgid ""
" -V, --verbose      explain what is being done;\n"
"                      specifying -V more than once will cause a dry-run\n"
msgstr ""

#: disk-utils/mkfs.c:49
#, c-format
msgid ""
" -V, --version      display version information and exit;\n"
"                      -V as --version must be the only option\n"
msgstr ""

You can see '-V' (uppercase) for both --verbose and --version. Is that correct?

2. Could the English wording be improved in the following sentence?

#: disk-utils/partx.c:312
#, fuzzy, c-format
#| msgid "This partition already exists.\n"
msgid "%s: partition #%d already doesn't exist\n"
msgstr ""

I would suggest something like:
msgid "%s: partition #%d doesn't exist\n"
msgid "%s: partition #%d no longer exists\n"

Regards,
Antonio Ceballos
