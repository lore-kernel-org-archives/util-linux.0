Return-Path: viro@ftp.linux.org.uk
Date: Fri, 19 Jan 2018 02:27:18 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Karel Zak <kzak@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@redhat.com>,
	"Eric W. Biederman" <ebiederm@redhat.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, util-linux@vger.kernel.org,
	"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: User-visible context-mount API
Message-ID: <20180119022717.GF13338@ZenIV.linux.org.uk>
References: <28167.1516032442@warthog.procyon.org.uk>
 <CAOssrKdgudK7kKbhQBAnV9EwzHBq=4+9M26JGfmhNDGrGXmnFg@mail.gmail.com>
 <1643.1516117204@warthog.procyon.org.uk>
 <CAOssrKdn-ZhOB9V28uL-JK9zgNGJzF4cFBeyoqLLj4pADqNFVQ@mail.gmail.com>
 <20180117041727.GS13338@ZenIV.linux.org.uk>
 <CAOssrKfN_ZT5yJC1mxkhUf6FG=_eMD4nzQtETfu_4X3vOf1kHw@mail.gmail.com>
 <20180117110633.zneqvnjzgxkv4yc2@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180117110633.zneqvnjzgxkv4yc2@ws.net.home>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 17, 2018 at 12:06:33PM +0100, Karel Zak wrote:

> What about new flag (for the API) rather than try to be smart with the
> current flags? But I have doubts that invest time to new mount(2)
> features is a good idea.

Would be nice, if we had any spare bits left...  We could, in principle,
turn
#define MS_BIND         4096
#define MS_MOVE         8192
into
#define MS_BIND         0x1000
#define MS_MOVE         0x2000
#define MS_SOMETHING    0x3000
seeing that they should never be used together, but... mount(2)
doesn't reject MS_BIND|MS_MOVE and treats it as MS_BIND instead.
_Probably_ nothing would care, but it risks breaking userland.

We could use one of the internal-only bits for that instead, but
they are also quietly ignored and not rejected, so that would
have the same problem.

mount(2) ABI sucks, film at 11...
