Return-Path: util-linux-owner@vger.kernel.org
Received: from frv190.fwdcdn.com ([212.42.77.190]:56294 "EHLO
	frv190.fwdcdn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbcDFMd3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2016 08:33:29 -0400
Received: from [10.10.1.26] (helo=frv197.fwdcdn.com)
	by frv190.fwdcdn.com with esmtp ID 1anm70-000KIR-I4
	for util-linux@vger.kernel.org; Wed, 06 Apr 2016 14:59:06 +0300
Received: from [10.10.10.45] (helo=frv45.fwdcdn.com)
	by frv197.fwdcdn.com with smtp ID 1anm6x-0007aM-4a
	for util-linux@vger.kernel.org; Wed, 06 Apr 2016 14:59:03 +0300
Date: Wed, 06 Apr 2016 14:59:03 +0300
From: Yuri Chornoivan <yurchor@ukr.net>
Subject: Re: question about translations
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Message-Id: <1459943512.225578245.2zzenkxg@frv45.fwdcdn.com>
In-Reply-To: <201604061259.21979.sweet_f_a@gmx.de>
References: <201604061259.21979.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

6 квітня 2016, 14:06:39, від "Ruediger Meier" <sweet_f_a@gmx.de>:
 
>   Hi,
> 
> I have no much knowledge about the whole translations thing but the new 
> setarch message "Execute command" looks odd to me.
> 
> $ git grep -A1 "Execute command" -- po/
> po/ca.po:msgid "Execute command `%s'.\n"
> po/ca.po-msgstr "S'està executant l'ordre date: %s\n"
> --
> po/cs.po:msgid "Execute command `%s'.\n"
> po/cs.po-msgstr "Spouští se příkaz „date„: %s\n"
> --
> po/da.po:msgid "Execute command `%s'.\n"
> po/da.po-msgstr "Udfører kommandoen date: %s\n"
> --
> po/de.po:msgid "Execute command `%s'.\n"
> po/de.po-msgstr "Der „date“-Befehl wird aufgerufen: %s\n"
> --
> [...]
> 
> Why they always say that "date" is executed?
> 
> 
> cu,
> Rudi

Hi,

These can be just fuzzy substitutions.

Example (Catalan, ca):

#: sys-utils/setarch.c:395
#, fuzzy, c-format
#| msgid "Issuing date command: %s\n"
msgid "Execute command `%s'.\n"
msgstr "S'està executant l'ordre date: %s\n"

Czech current from TP has correct translation:

#: sys-utils/setarch.c:395
#, c-format
msgid "Execute command `%s'.\n"
msgstr "Spouští se příkaz „%s“.\n"

So, I guess, there is nothing to worry now.

Best regards,
Yuri
Ukrainian translator
 
 
