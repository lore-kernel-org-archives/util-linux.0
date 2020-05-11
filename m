Return-Path: <SRS0=QCn3=6Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A4C54E4B
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D1820801
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 10:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbdUxtdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgEKKcV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 May 2020 06:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbgEKKcV (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 11 May 2020 06:32:21 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE9AC061A0C
        for <util-linux@vger.kernel.org>; Mon, 11 May 2020 03:32:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so7454915ejd.8
        for <util-linux@vger.kernel.org>; Mon, 11 May 2020 03:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PHzL2dAzl6PLGGcg5/hhWdmV0IrcxLVW6g3qrNVyRPQ=;
        b=gbdUxtdBVVzkClhxyUr4DSNYUwBHF3fMbu4yJkmWclJ3+euoDZlz87MRWItfLotxGn
         J2RHsPD6mqhrH2WuERuLOo6h2jQrO5kIQdQCL5Qez+Z/2VxQhFFg/9CSKIYd97hJO8ev
         tK4bMN79hRxU8BnyfeCgvJI0gGqJRkHN/qHClh5KrRiEkGUZF7MgybmymswEcwYg2VH/
         1GPnIZUgrkjC1oQTKS+2up5X2UujAxF1SXI1v11U0RGX7MYEN7j4TaqHH5vvW5AaYdLz
         tKAPqDffREYedZVOuegJgkgaHIFO2VnCN2vbi6ZzVu9xGORuXM83J+djoYNWIK9FAdet
         GzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PHzL2dAzl6PLGGcg5/hhWdmV0IrcxLVW6g3qrNVyRPQ=;
        b=DCc3O/urjV33pIl88ds6COHoZWKSR1CDMjIVEC6vrTrS92aQecMJGlfif/G4kpMUSl
         UIQUjByEy7CccJToQeXze3FLoLz9/7/djuPd8JO/bKyjCPackXPl+n11cg1FGzlVBdoj
         JbzaUdNTNqQ5sDuMXxa+VXAHSV5NcYx+zwv520FQecXDLXj3OpTjYsDiSvDBRxU9cypO
         SJHYOTdT8gsvvaH9E02GR6+h2bDg5h8r6OB24TPAgIdDx8Zh2xyncGzDSnOeojjx04p7
         /hmeXVR5Ery6VTynwIMSQfH0DxyT3umUhuDAmw+M6EpGKpNS8vkNae/aZvc6RCzcD29M
         RkGw==
X-Gm-Message-State: AGi0PublK5whpuQkunmOYu0zQPhzvy12tXEtNVJgTtFonr9H+xcYDyUU
        1E+QA0up28E2aFJvR6VbWT5Pozcx7SCL0bz7rW8=
X-Google-Smtp-Source: APiQypLdcmEpYkWkzkj1SykxIUg10Tq36aeoM3aucqVDAVJ+WcRURFZGv9RYw0hDEpB5iFy1YkFdTUN0Jo0/EAjm9wI=
X-Received: by 2002:a17:906:2604:: with SMTP id h4mr12154257ejc.307.1589193139495;
 Mon, 11 May 2020 03:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200503191335.GB27970@Debian-50-lenny-64-minimal>
 <CALxWeYrDdow1y2oA1VkcCyiQH1Vm9jNN79o541FPRaHYom=pAg@mail.gmail.com>
 <20200509190020.GA28852@Debian-50-lenny-64-minimal> <CALxWeYpxvs+fcXzbExJ0n5ebeFtBdzm53ucPndW475CKe2KR0Q@mail.gmail.com>
 <20200511092734.6izjgahtz37iya6v@ws.net.home>
In-Reply-To: <20200511092734.6izjgahtz37iya6v@ws.net.home>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 11 May 2020 12:32:08 +0200
Message-ID: <CAKgNAkgqKs=Q4qvPHirHa6KjW3qOqyyNG7sCxHX2RfWiOBqRbg@mail.gmail.com>
Subject: Re: Errors in man pages of util-linux
To:     Karel Zak <kzak@redhat.com>
Cc:     Helge Kreutzmann <debian@helgefjell.de>,
        util-linux@vger.kernel.org,
        =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel

On Mon, 11 May 2020 at 11:27, Karel Zak <kzak@redhat.com> wrote:
>
> On Sat, May 09, 2020 at 09:05:50PM +0200, Michael Kerrisk wrote:
> > On Sat, May 9, 2020 at 9:00 PM Helge Kreutzmann <debian@helgefjell.de> wrote:
> > >
> > > Hello Michael,
> > > On Sat, May 09, 2020 at 08:53:31PM +0200, Michael Kerrisk wrote:
> > > > Hello Helge ;-),
>
> Thanks for your report Helge.
>
> > > > I think no maintainer wants to deal with a 1000-line mail listing 100+
> > > > minor bugs. May I suggest making the maintainer's life a little easier
> > > > by breaking things up into pieces. For example, one mail per manual
> > > > page (which would be 43 mails by my count).  But maybe Karel has
> > > > another suggestion on how you could make his life easier.
>
> Well, that's simple, send patches ;-)))

So, I've recently been through this process with Helge for 100+
man-pages bug reports.Here's my experience/summary for what its worth:
* Because of info I have on the project website, Helge sent bug reports
  one per mail, so one day without warning, I got 138 mails :-).
  (My preference really is separate mails for each issue. But I told
  Helge I would have liked a little warning first :-).)

* A large number of the reports just required simple one-line edits that
  could often be done in a minute.
* It was clear that the effort required for Helge to make patches would
  be rather greater than me just doing the one-line edits
* Making patches requires an added layer of work for Helge, since
  he/the translators are working with a mutated version of the source.
  (The flip side of this is that it is occasionally a little tricky to convert
  the text that Helge is sending you back to the corresponding page
  source.)

> > Maybe hold off for a day or three before investing effort on this.
> > Karel may have a better idea than mine re his preferred method of
> > reporting.
>
> I have no another idea (maybe github issue(s), but it will be invisible
> for many contributors).

Have mercy! Please no... :-).

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
