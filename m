Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:62676 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbcDFK72 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2016 06:59:28 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MHoWj-1ap7gn0ip3-003Znz for
 <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 12:59:24 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: question about translations
Date: Wed, 6 Apr 2016 11:59:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201604061259.21979.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I have no much knowledge about the whole translations thing but the new 
setarch message "Execute command" looks odd to me.

$ git grep -A1 "Execute command" -- po/
po/ca.po:msgid "Execute command `%s'.\n"
po/ca.po-msgstr "S'està executant l'ordre date: %s\n"
--
po/cs.po:msgid "Execute command `%s'.\n"
po/cs.po-msgstr "Spouští se příkaz „date„: %s\n"
--
po/da.po:msgid "Execute command `%s'.\n"
po/da.po-msgstr "Udfører kommandoen date: %s\n"
--
po/de.po:msgid "Execute command `%s'.\n"
po/de.po-msgstr "Der „date“-Befehl wird aufgerufen: %s\n"
--
[...]

Why they always say that "date" is executed?


cu,
Rudi
