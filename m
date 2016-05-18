Return-Path: ico2ico2@gmail.com
MIME-Version: 1.0
Sender: ico2ico2@gmail.com
In-Reply-To: <20160518123103.v3tdgj4aclg3cc6c@ws.net.home>
References: <1463054083-2485-1-git-send-email-sassan@sassan.me.uk>
	<1463054083-2485-4-git-send-email-sassan@sassan.me.uk>
	<20160518123103.v3tdgj4aclg3cc6c@ws.net.home>
Date: Wed, 18 May 2016 14:51:14 +0100
Message-ID: <CAAz8cFitELaSQaZ+=cHqnOMmGpcFNxR11=FTYtiQHuV1BLob+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sfdisk: Add support for altering GPT size
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Good idea!

Thanks!

On 18 May 2016 at 13:31, Karel Zak <kzak@redhat.com> wrote:
> On Thu, May 12, 2016 at 12:54:43PM +0100, Sassan Panahinejad wrote:
>>  libfdisk/src/script.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> Applied, thanks.
>
> I have also added "table-length" to the --dump output if table length
> is different than the default.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
