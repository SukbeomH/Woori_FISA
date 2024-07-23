import streamlit as st

val1 = st.button("IMAGE 1")
val2 = st.button("IMAGE 2")
val3 = st.button("IMAGE 3")

if val1:
    st.image("./data/giveme.jpeg")
elif val2:
    st.image("./data/pika.jpeg")
elif val3:
    st.image("./data/rightparrot.gif")