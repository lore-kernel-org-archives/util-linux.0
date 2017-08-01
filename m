Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.datacom.ind.br ([177.66.5.10]:36605 "EHLO
        mail.datacom.ind.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751106AbdHAAOe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 20:14:34 -0400
Received: from mail.datacom.ind.br (localhost [127.0.0.1])
        by mail.datacom.ind.br (Postfix) with ESMTPS id 4865E150735A
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 21:12:03 -0300 (BRT)
Received: from localhost (localhost [127.0.0.1])
        by mail.datacom.ind.br (Postfix) with ESMTP id 39F2D1507345
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 21:12:03 -0300 (BRT)
Received: from mail.datacom.ind.br ([127.0.0.1])
        by localhost (mail.datacom.ind.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x7iDLh37urb8 for <util-linux@vger.kernel.org>;
        Mon, 31 Jul 2017 21:12:03 -0300 (BRT)
Received: from mail.datacom.ind.br (mail.datacom.ind.br [172.25.4.13])
        by mail.datacom.ind.br (Postfix) with ESMTP id 2332C1507355
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 21:12:03 -0300 (BRT)
Date: Mon, 31 Jul 2017 21:12:03 -0300 (BRT)
From: Carlos Santos <casantos@datacom.ind.br>
To: util-linux@vger.kernel.org
Message-ID: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
Subject: Problem building util-linux without a separate ncursesw include dir
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Since commit 3947ca4ca (build-sys: ncurses headers cleanup), util-linux
assumes that ncursesw headers are in an "ncursesw" subdirectory. That's
valid on systems that have both ncurses variants but not on embedded
systems like Buildroot on which only one variant is build, with headers
always installed directly at /usr/include.

I added a patch to revert commit 3947ca4ca to the Buildroot recipe but
such a drastic solution can easily become incompatible with new versions
of util-linux. Would it be possible to make the location of ncursesw
headers configurable, instead?

Thanks in advance.

-- 
Carlos Santos (Casantos) - DATACOM, P&D
Rua América, 1000 - Eldorado do Sul, RS, Brasil - 92990-000
casantos@datacom.ind.br          +55 51 3933.3000 ext. 3627
http://www.datacom.ind.br
