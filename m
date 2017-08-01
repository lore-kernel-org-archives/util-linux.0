Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.datacom.ind.br ([177.66.5.10]:38046 "EHLO
        mail.datacom.ind.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751655AbdHAAtL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 20:49:11 -0400
Received: from mail.datacom.ind.br (localhost [127.0.0.1])
        by mail.datacom.ind.br (Postfix) with ESMTPS id BC6C315073BD
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 21:46:39 -0300 (BRT)
Received: from localhost (localhost [127.0.0.1])
        by mail.datacom.ind.br (Postfix) with ESMTP id B06E015073BA
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 21:46:39 -0300 (BRT)
Received: from mail.datacom.ind.br ([127.0.0.1])
        by localhost (mail.datacom.ind.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WeZ3anUE8vnL for <util-linux@vger.kernel.org>;
        Mon, 31 Jul 2017 21:46:39 -0300 (BRT)
Received: from mail.datacom.ind.br (mail.datacom.ind.br [172.25.4.13])
        by mail.datacom.ind.br (Postfix) with ESMTP id A011515073BB
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 21:46:39 -0300 (BRT)
Date: Mon, 31 Jul 2017 21:46:39 -0300 (BRT)
From: Carlos Santos <casantos@datacom.ind.br>
To: util-linux@vger.kernel.org
Message-ID: <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
In-Reply-To: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: "Carlos Santos" <casantos@datacom.ind.br>
> To: util-linux@vger.kernel.org
> Sent: Monday, July 31, 2017 9:12:03 PM
> Subject: Problem building util-linux without a separate ncursesw include dir

> of util-linux. Would it be possible to make the location of ncursesw
> headers configurable, instead?

I was thinking on something simple, like https://pastebin.com/VqM9G9yu

-- 
Carlos Santos (Casantos) - DATACOM, P&D
“The greatest triumph that modern PR can offer is the transcendent 
success of having your words and actions judged by your reputation, 
rather than the other way about.” — Christopher Hitchens
